<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class References_cabang extends CI_Controller {
    
    private $arrMenuConfig;
    private $arrController;
    private $conn;

    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        
        $tmpController      = explode("_", $this->uri->segment(1)) ; 
        $controllerSelected = $tmpController[1];
        $activeModule       = $this->session->userdata('setmodule');
        $modulID            = $this->conn->CIT_GETSOMETHING("modulID", 'conf_modul', array('modulPage_Form_Controller'=>$activeModule));
        
        $submodulID         = $this->conn->CIT_GETSOMETHING("submodulID", 'conf_menu', array('controller'=>$controllerSelected));
        $submodulNama       = $this->conn->CIT_GETSOMETHING("submodulNama", 'conf_submodul', array('modulID'=>$modulID,'submodulID'=>$submodulID));
         
        $this->arrMenuConfig = array('SubModul'=>$submodulNama,'menu'=>$controllerSelected);
        $this->arrController = $tmpController[0]."_".$controllerSelected;
        
        $this->load->library('session');
        $logged = $this->session->userdata('username');
        if ((!isset($logged)) || ($logged=='') || ( empty ($logged) ) ){ 
            redirect('login','refresh'); 
        }else{ 
            if ((!isset($activeModule)) || ($activeModule=="")|| ( empty ($activeModule) )){ 
                redirect('setmodule','');
            }else{ 

            }
        }
    }

    public function index()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_cabang'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'bankID'=>  $this->conn->CIT_AUTONUMBER_MAX("bankID", "tref_bank")
             , 'listBank'=> $this->loadBank()
            , 'loadBankCabang'=> $this->loadBankCabang()
            , 'listKota'=>  $this->loadKota() 
            , 'listPropinsi'=> $this->loadPrinsi()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    public function msg()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_cabang'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'bankID'=>  $this->conn->CIT_AUTONUMBER_MAX("bankID", "tref_bank")
             , 'listBank'=> $this->loadBank()
            , 'loadBankCabang'=> $this->loadBankCabang()
            , 'listKota'=>  $this->loadKota() 
            , 'listPropinsi'=> $this->loadPrinsi()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function hapusMultiple(){
        $activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $PropID  = explode(',',$_REQUEST["cabangID"]);
        $hasil ="0";
        for ($i = 0;$i<count($PropID);$i++){
            $hasil = $this->conn->CIT_DELETE("normal", "tref_bank_cabang", array("cabangID" => $PropID[$i]));
        }
        echo $hasil;
        if ($hasil == "1"){
            //redirect($activeModule.'_cabang/msg/success', 'refresh');
        }  else {
            //redirect($activeModule.'_cabang/msg/fail', 'refresh');
        }
    }
    
    public function hapus(){
        $activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $hasil = $this->conn->CIT_DELETE("normal", "tref_bank_cabang", array("cabangID" => $requestID));
        
        if ($hasil == "1"){
            redirect($activeModule.'_cabang/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_cabang/msg/fail', 'refresh');
        }
    }

    public function entry()
    {
        $activeModule   = $this->session->userdata('setmodule');
        
        $hasil = $this->conn->CIT_INSERT("tref_bank_cabang", array(
            "cabangNama" => $_POST["cabangNama"],
            "alamat" => $_POST["modalAlamat"],
            "bankID" => $_POST["modalBankID"],
            "email" => $_POST["modalEmail"],
            "fax" => $_POST["modalFax"],
            "kodePos" => $_POST["modalKodePos"],
            "kotaID" => $_POST["modalKotaID"],
            "namaKontak" => $_POST["modalNamaKontak"],
            "propinsiID" => $_POST["modalPropinsiID"],
            "telepon" => $_POST["modalTelepon"]
        ));
        
        if ($hasil == "1"){
            redirect($activeModule.'_cabang/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_cabang/msg/fail', 'refresh');
        }
    }
    
    public function update()
    {
        $activeModule   = $this->session->userdata('setmodule');
        
        $hasil = $this->conn->CIT_UPDATE("tref_bank_cabang", array(
            "cabangNama" => $_POST["cabangNama"],
            "alamat" => $_POST["modalAlamat"],
            "bankID" => $_POST["modalBankID"],
            "email" => $_POST["modalEmail"],
            "fax" => $_POST["modalFax"],
            "kodePos" => $_POST["modalKodePos"],
            "kotaID" => $_POST["modalKotaID"],
            "namaKontak" => $_POST["modalNamaKontak"],
            "propinsiID" => $_POST["modalPropinsiID"],
            "telepon" => $_POST["modalTelepon"]
        ),array("cabangID" => $_POST["cabangID"]));
        
        if ($hasil == "1"){
            redirect($activeModule.'_cabang/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_cabang/msg/fail', 'refresh');
        }

    }
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('view_bank_cabang');
        
        $table = "";
        $n = 1;
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"fieldID[]\" id=\"fieldID[]\" value=\"".$r["cabangID"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["bankName"]."</td>";
            $table .= "<td>".$r["cabangNama"]."</td>";
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["cabangID"]."','".$r["bankID"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a class=\"btn btn-mini btn-square tip\" href=\"".site_url($this->arrController."/hapus/id/".$r["cabangID"])."\" data-original-title=\"Hapus\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/cross.png\"/>";
            $table .= "</a>";
            $table .= "</td>";
        $table .= "</tr>";
        $n++;
        }
        return array('content'=>$table);
    }
    
    public function loadBank(){
       return $this->conn->CIT_SELECT('tref_bank');
    }
    public function loadBankCabang(){
       return $this->conn->CIT_SELECT('tref_bank_cabang');
    }
    public function loadPrinsi(){
       return $this->conn->CIT_SELECT('tref_propinsi');
    }
    public function loadKota(){
       return $this->conn->CIT_SELECT('tref_city');
    }
    
    public function getCabang(){
        $bankID = $_POST["bankID"];
        $cabangID = $_POST["cabangID"];
        $array = $this->conn->CIT_SELECT('tref_bank_cabang', 'equal', array('bankID'=>$bankID,'cabangID'=>$cabangID));
        $result = array();
        foreach ($array as $value) {
            array_push($result,array(
                "cabangID" => $value["cabangID"],
                "cabangNama" => $value["cabangNama"],
                "modalAlamat" => $value["alamat"],
                "modalBankID" => $value["bankID"],
                "modalEmail" => $value["email"],
                "modalFax" => $value["fax"],
                "modalKodePos" => $value["kodePos"],
                "modalKotaID" => $value["kotaID"],
                "modalNamaKontak" => $value["namaKontak"],
                "modalPropinsiID" => $value["propinsiID"],
                "modalTelepon" => $value["telepon"]   
            ));
            
        }
        echo json_encode($result);
        
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */