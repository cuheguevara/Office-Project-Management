<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Human_resources_karyawan extends CI_Controller {
    
    private $arrMenuConfig;
    private $arrController;
    private $selectedSubModule;
    private $activeModule;
    
    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        
        $tmpController      = explode("_", $this->uri->segment(1)) ; 
        $controllerSelected = $tmpController[2];
        $this->activeModule = $this->session->userdata('setmodule');
        $modulID            = $this->conn->CIT_GETSOMETHING("modulID"
        		, 'conf_modul'
        		, array('modulPage_Form_Controller'=>$this->activeModule));
        
        $this->selectedSubModule = $controllerSelected;
        
        $submodulID         = $this->conn->CIT_GETSOMETHING("submodulID"
        		, 'conf_menu'
        		, array('controller'=>$controllerSelected));
        $submodulNama       = $this->conn->CIT_GETSOMETHING("submodulNama", 'conf_submodul', array('modulID'=>$modulID,'submodulID'=>$submodulID));
         
        $this->arrMenuConfig = array(
        		'SubModul'=>$submodulNama
        		,'menu'=>$controllerSelected
        );
        
        $this->arrController = $tmpController[0]."_".$tmpController[1]."_".$controllerSelected;
        
        $this->load->library('session');
        $logged = $this->session->userdata('username');
        if ((!isset($logged)) || ($logged=='') || ( empty ($logged) ) ){ 
            redirect('login','refresh'); 
        }else{ 
            if ((!isset($this->activeModule)) || ($this->activeModule=="")|| ( empty ($this->activeModule) )){ 
                redirect('setmodule','');
            }else{ 

            }
        }
    }

    public function index()
    {
        $this->activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $this->activeModule.'/view_'.$this->activeModule."_".$this->selectedSubModule
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'noregistrasikaryawan'=>  $this->conn->CIT_AUTONUMBER("tref_karyawan", "noregistrasikaryawan", "REG".date("ymd"), 3)
            , 'nip'=>  $this->conn->CIT_AUTONUMBER("tref_karyawan", "nip", "NIP".date("ymd"), 3)
            , 'listKota'=>  $this->loadKota() 
            , 'listPropinsi'=> $this->loadPrinsi()
            , 'listBank'=> $this->loadBank()
            , 'loadBankCabang'=> $this->loadBankCabang()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function msg()
    {
        $this->activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $this->activeModule.'/view_'.$this->activeModule."_".$this->selectedSubModule
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'noregistrasikaryawan'=>  $this->conn->CIT_AUTONUMBER("tref_karyawan", "noregistrasikaryawan", "REG".date("ymd"), 3)
            , 'nip'=>  $this->conn->CIT_AUTONUMBER("tref_karyawan", "nip", "NIP".date("ymd"), 3)
            , 'listKota'=>  $this->loadKota() 
            , 'listPropinsi'=> $this->loadPrinsi()
            , 'listBank'=> $this->loadBank()
            , 'loadBankCabang'=> $this->loadBankCabang()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function hapusMultiple(){
        $this->activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        echo $requestID;
        $PropID  = explode(',',$_REQUEST["nip"]);
        for ($i = 0;$i<count($PropID);$i++){
            $hasil = $this->conn->CIT_DELETE("normal", "tref_karyawan", array("nip" => $PropID[$i]));
        }
        echo $hasil;
    }
    
    public function hapus(){
        $this->activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $hasil = $this->conn->CIT_DELETE("normal", "tref_karyawan", array("nip" => $requestID));
        
        if ($hasil == "1"){
            redirect($this->activeModule.'_jabatan/msg/success', 'refresh');
        }  else {
            redirect($this->activeModule.'_jabatan/msg/fail', 'refresh');
        }
    }

    public function loadPrinsi(){
       return $this->conn->CIT_SELECT('tref_propinsi');
    }
    public function loadBank(){
       return $this->conn->CIT_SELECT('tref_bank');
    }
    public function loadBankCabang(){
       return $this->conn->CIT_SELECT('tref_bank_cabang');
    }
    
    public function loadKota(){
       return $this->conn->CIT_SELECT('tref_city');
    }
    public function entry()
    {
        $this->activeModule   = $this->session->userdata('setmodule');
        $propinsiID = $this->conn->CIT_GETSOMETHING("propinsiID", "tref_city", array("kotaID"=>$_POST["kotaID"]));
        $tLahir = explode("/", $_POST["tanggalLahir"]);
        $bankID = $_POST["bankID"];
        $fieldDataPribadi = array("nip"=>$_POST["nip"]
            , "noregistrasikaryawan"=>$_POST["noregistrasikaryawan"]
            , "npwp"=>$_POST["npwp"]
            , "noKTPSIM"=>$_POST["noKTPSIM"]
            , "noJamsostek"=>$_POST["noJamsostek"]
            , "namaLengkap"=>$_POST["namaLengkap"]
            , "namaPanggilan"=>$_POST["namaPanggilan"]
            , "tanggalLahir"=>date("Y-m-d", strtotime($_POST["tanggalLahir"]))
            , "tempatLahir"=>$_POST["tempatLahir"]
            , "gender"=>$_POST["gender"]
            , "agama"=>$_POST["agama"]);
        
        $fieldDataKontak = array("alamat"=>$_POST["alamat"]
            , "propinsiID"=>$_POST["propinsiID"]
            , "kotaID"=>$_POST["kotaID"]
            , "kodePos"=>$_POST["kodePos"]
            , "nomortelepon"=>$_POST["nomortelepon"]
            , "email"=>$_POST["email"]
            );
        
        $fieldDataBank = array("accRekening"=>$_POST["accRekening"]
            , "noRekening"=>$_POST["noRekening"]
            , "cabangID"=>$_POST["cabangID"]
            , "bankID"=>$_POST["bankID"]
            , "email"=>$_POST["email"]
            );
        $dataInsert = array_merge($fieldDataPribadi,$fieldDataKontak,$fieldDataBank);    
        try{
            $hasil = $this->conn->CIT_INSERT('tref_karyawan', $dataInsert);
            
            if ($hasil == "1"){
                redirect($this->activeModule.'_karyawan/msg/success', 'refresh');
            }  else {
                redirect($this->activeModule.'_karyawan/msg/fail', 'refresh');
            }
        }catch(Exception $e){
            redirect($this->activeModule.'_karyawan/msg/fail', 'refresh');
        }
        
    }
    
    public function update()
    {
        $this->activeModule   = $this->session->userdata('setmodule');
        
        $hasil = $this->conn->CIT_UPDATE("tref_jabatan", array(
            "jabatanNama" => $_POST["jabatanNama"]
        ),array("jabatanID" => $_POST["jabatanID"]));
        
        if ($hasil == "1"){
            redirect($this->activeModule.'_jabatan/msg/success', 'refresh');
        }  else {
            redirect($this->activeModule.'_jabatan/msg/fail', 'refresh');
        }

    }
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('view_karyawan');
        
        $table = "";
        $n = 1;
        
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"fieldID[]\" id=\"fieldID[]\" value=\"".$r["nip"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["nip"]."</td>";
            $table .= "<td>".$r["namaLengkap"]."</td>";
            $table .= "<td>".$r["alamat"].", ".$r["kota"]." - ".$r["propinsi"]."</td>";
            $table .= "<td>".$r["email"]."</td>";
            
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["nip"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a class=\"btn btn-mini btn-square tip\" href=\"".site_url($this->arrController."/hapus/id/".$r["nip"])."\" data-original-title=\"Hapus\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/cross.png\"/>";
            $table .= "</a>";
            $table .= "</td>";
        $table .= "</tr>";
        $n++;
        }
        return array('content'=>$table);
    }
    
}

/* End of file Human_resources_jabatan.php */
/* Location: ./application/controllers/Human_resources_jabatan.php */