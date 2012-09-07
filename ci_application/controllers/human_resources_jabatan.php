<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Human_resources_jabatan extends CI_Controller {
    
    private $arrMenuConfig;
    private $arrController;


    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        
        $tmpController      = explode("_", $this->uri->segment(1)) ; 
        $controllerSelected = $tmpController[2];
        $activeModule       = $this->session->userdata('setmodule');
        $modulID            = $this->conn->CIT_GETSOMETHING("modulID", 'conf_modul', array('modulPage_Form_Controller'=>$activeModule));
        
        $submodulID         = $this->conn->CIT_GETSOMETHING("submodulID", 'conf_menu', array('controller'=>$controllerSelected));
        $submodulNama       = $this->conn->CIT_GETSOMETHING("submodulNama", 'conf_submodul', array('modulID'=>$modulID,'submodulID'=>$submodulID));
         
        $this->arrMenuConfig = array('SubModul'=>$submodulNama,'menu'=>$controllerSelected);
        $this->arrController = $tmpController[0]."_".$tmpController[1]."_".$controllerSelected;
        
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
            'mainview' => $activeModule.'/view_'.$activeModule.'_bank'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'bankID'=>  $this->conn->CIT_AUTONUMBER_MAX("bankID", "tref_bank")
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    public function msg()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_bank'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'bankID'=>  $this->conn->CIT_AUTONUMBER_MAX("bankID", "tref_bank")
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function hapusMultiple(){
        $activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $PropID  = explode(',',$_REQUEST["bankID"]);
        for ($i = 0;$i<count($PropID);$i++){
            $hasil = $this->conn->CIT_DELETE("normal", "tref_bank", array("bankID" => $PropID[$i]));
        }
        
        if ($hasil == "1"){
            redirect($activeModule.'_bank/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_bank/msg/fail', 'refresh');
        }
    }
    
    public function hapus(){
        $activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $hasil = $this->conn->CIT_DELETE("normal", "tref_bank", array("bankID" => $requestID));
        
        if ($hasil == "1"){
            redirect($activeModule.'_bank/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_bank/msg/fail', 'refresh');
        }
    }

    public function entry()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $hasil = $this->conn->CIT_INSERT("tref_bank", array(
            "bankID" => $_POST["bankID"],
            "bankName" => $_POST["bankName"],
            "bankFullName" => $_POST["bankFullName"]
        ));
        
        if ($hasil == "1"){
            redirect($activeModule.'_bank/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_bank/msg/fail', 'refresh');
        }
    }
    
    public function update()
    {
        $activeModule   = $this->session->userdata('setmodule');
        
        $hasil = $this->conn->CIT_UPDATE("tref_bank", array(
            "bankName" => $_POST["bankName"],
            "bankFullName" => $_POST["bankFullName"]
        ),array("bankID" => $_POST["bankID"]));
        
        if ($hasil == "1"){
            redirect($activeModule.'_bank/msg/success', 'refresh');
        }  else {
            redirect($activeModule.'_bank/msg/fail', 'refresh');
        }

    }
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('tref_bank');
        
        $table = "";
        $n = 1;
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"fieldID[]\" id=\"fieldID[]\" value=\"".$r["bankID"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["bankID"]."</td>";
            $table .= "<td>".$r["bankName"]."</td>";
            $table .= "<td>".$r["bankFullName"]."</td>";
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["bankID"]."','".$r["bankName"]."','".$r["bankFullName"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a class=\"btn btn-mini btn-square tip\" href=\"".site_url($this->arrController."/hapus/id/".$r["bankID"])."\" data-original-title=\"Hapus\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/cross.png\"/>";
            $table .= "</a>";
            $table .= "</td>";
        $table .= "</tr>";
        $n++;
        }
        return array('content'=>$table);
    }
    
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */