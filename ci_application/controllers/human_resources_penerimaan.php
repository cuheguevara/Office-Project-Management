<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Human_resources_penerimaan extends CI_Controller {
    
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
            , 'listKaryawan'=>  $this->comboKaryawan() 
            , 'listDepartment'=> $this->comboDepartemen()
            , 'listJabatan'=> $this->comboJabatan()
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
            , 'listKaryawan'=>  $this->comboKaryawan() 
            , 'listDepartment'=> $this->comboDepartemen()
            , 'listJabatan'=> $this->comboJabatan()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    private function comboKaryawan()
    {
        $result = "";
        $result .= "<option value=\"*\">Cari Karyawan</option>";
        foreach($this->loadKaryawan() as $r){
            $result .= "<option value=\"".$r["nip"]."\">".$r["namaLengkap"]."</option>";
        }
        return $result;    
    }
    
    private function comboDepartemen()
    {
        $result = "";
        $result .= "<option value=\"*\">Cari Departemen</option>";
        foreach($this->loadDepartemen() as $r){
            $result .= "<option value=\"".$r["departemenID"]."\">".$r["departemenNama"]."</option>";
        }
        return $result;    
    }
    
    private function comboJabatan()
    {
        $result = "";
        $result .= "<option value=\"*\">Cari Jabatan</option>";
        foreach($this->loadJabatan() as $r){
            $result .= "<option value=\"".$r["jabatanID"]."\">".$r["jabatanNama"]."</option>";
        }
        return $result;    
    }
    
    public function loadKaryawan()
    {
       return $this->conn->CIT_SELECT('view_karyawan');
    }
    
    public function loadDepartemen()
    {
       return $this->conn->CIT_SELECT('tref_departemen');
    }
    
    public function loadJabatan()
    {
       return $this->conn->CIT_SELECT('tref_jabatan');
    }
    
    public function getKaryawan(){
        $this->activeModule = $this->session->userdata('setmodule');
        $table  = "view_karyawan";
        $nip                = $_POST["nip"];
        $dataKaryawan       = array();
        $konsidi            = array("nip"=>$nip);
        $karyawan           = $this->conn->CIT_SELECT($table,"equal", $konsidi);
        foreach ($karyawan as $row) {
            array_push($dataKaryawan, array(
                "nip" => $row["nip"]
                ,"npwp" => $row["npwp"]
                , "noKTPSIM" => $row["noKTPSIM"]
                , "noJamsostek" => $row["noJamsostek"]
                , "namaLengkap" => $row["namaLengkap"]
                , "namaPanggilan" => $row["namaPanggilan"]
                , "tanggalLahir" => date("m/d/Y", strtotime($row["tanggalLahir"]))
                , "tempatLahir" => $row["tempatLahir"]
                , "gender" => $row["gender"]
                , "agama" => $row["agama"]
                , "alamat" => $row["alamat"]
                , "propinsiID" => $row["propinsiID"]
                , "propinsi" => $row["propinsi"]
                , "kotaID" => $row["kotaID"]
                , "kota" => $row["kota"]
                , "kodePos" => $row["kodePos"]
                , "nomortelepon" => $row["nomortelepon"]
                , "email" => $row["email"]
                , "noregistrasikaryawan" => $row["noregistrasikaryawan"]
                , "bankID" => $row["bankID"]
                , "cabangID" => $row["cabangID"]
                , "noRekening" => $row["noRekening"]
                , "accRekening" => $row["accRekening"]
                , "status" => $row["status"]
            ));
        }
        echo json_encode($dataKaryawan);
    }
    
    public function entry()
    {
        $this->activeModule     = $this->session->userdata('setmodule');
        $periodeTahunAwal       = date("Y", strtotime($_POST["periodeAwal"]));
        $periodeTahunAkhir      = date("Y", strtotime($_POST["periodeAkhir"]));
        $periodeAwal            = date("Y-m-d", strtotime($_POST["periodeAwal"]));
        $periodeAkhir           = date("Y-m-d", strtotime($_POST["periodeAkhir"]));
        
        $fieldDataPribadi = array(
            "menjabatID"=>  $this->conn->CIT_AUTONUMBER("t_menjabat", "menjabatID", "PA/".$periodeTahunAwal."/".$periodeTahunAkhir."/", "5")
            ,"periodeAwal"=>$periodeAwal
            , "periodeAkhir"=>$periodeAkhir
            , "nip"=>$_POST["nip"]
            , "departemenID"=>$_POST["departemenID"]
            , "jabatanID"=>$_POST["jabatanID"]
            , "periodeTahunAwal"=>$periodeTahunAwal
            , "periodeTahunAkhir"=>$periodeTahunAkhir
            , "besarTHP"=>$_POST["besarTHP"]
            , "jenisGaji"=>$_POST["jenisGaji"]);
        
        try{
            $hasil = $this->conn->CIT_INSERT('t_menjabat', $fieldDataPribadi);
            
            if ($hasil == "1"){
                redirect($this->activeModule.'_penerimaan/msg/success', 'refresh');
            }  else {
                redirect($this->activeModule.'_penerimaan/msg/fail', 'refresh');
            }
        }catch(Exception $e){
            redirect($this->activeModule.'_penerimaan/msg/fail', 'refresh');
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