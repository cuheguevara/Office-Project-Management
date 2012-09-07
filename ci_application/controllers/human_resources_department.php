<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Human_resources_department extends CI_Controller {
    
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
        $modulID            = $this->conn->CIT_GETSOMETHING("modulID", 'conf_modul', array('modulPage_Form_Controller'=>$this->activeModule));
        
        $this->selectedSubModule = $controllerSelected;
        
        $submodulID         = $this->conn->CIT_GETSOMETHING("submodulID", 'conf_menu', array('controller'=>$controllerSelected));
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
            , 'departemenID'=>  $this->conn->CIT_AUTONUMBER("tref_departemen", "departemenID", "D-", 3)
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
            , 'departemenID'=>  $this->conn->CIT_AUTONUMBER("tref_departemen", "departemenID", "D-", 3)
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function hapusMultiple(){
        $this->activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $PropID  = explode(',',$_REQUEST["departemenID"]);
        for ($i = 0;$i<count($PropID);$i++){
            $hasil = $this->conn->CIT_DELETE("normal", "tref_departemen", array("departemenID" => $PropID[$i]));
        }
        
        if ($hasil == "1"){
            redirect($this->activeModule.'_department/msg/success', 'refresh');
        }  else {
            redirect($this->activeModule.'_department/msg/fail', 'refresh');
        }
    }
    
    public function hapus(){
        $this->activeModule   = $this->session->userdata('setmodule');
        $requestID      = $this->uri->segment(4);
        
        $hasil = $this->conn->CIT_DELETE("normal", "tref_departemen", array("departemenID" => $requestID));
        
        if ($hasil == "1"){
            redirect($this->activeModule.'_department/msg/success', 'refresh');
        }  else {
            redirect($this->activeModule.'_department/msg/fail', 'refresh');
        }
    }

    public function entry()
    {
        $this->activeModule   = $this->session->userdata('setmodule');
        $hasil = $this->conn->CIT_INSERT("tref_departemen", array(
            "departemenID" => $_POST["departemenID"],
            "departemenNama" => $_POST["departemenNama"]
        ));
        
        if ($hasil == "1"){
            redirect($this->activeModule.'_department/msg/success', 'refresh');
        }  else {
            redirect($this->activeModule.'_department/msg/fail', 'refresh');
        }
    }
    
    public function update()
    {
        $this->activeModule   = $this->session->userdata('setmodule');
        
        $hasil = $this->conn->CIT_UPDATE("tref_departemen", array(
            "departemenNama" => $_POST["departemenNama"]
        ),array("departemenID" => $_POST["departemenID"]));
        
        if ($hasil == "1"){
            redirect($this->activeModule.'_department/msg/success', 'refresh');
        }  else {
            redirect($this->activeModule.'_department/msg/fail', 'refresh');
        }

    }
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('tref_departemen');
        
        $table = "";
        $n = 1;
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"fieldID[]\" id=\"fieldID[]\" value=\"".$r["departemenID"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["departemenNama"]."</td>";
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["departemenID"]."','".$r["departemenNama"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a class=\"btn btn-mini btn-square tip\" href=\"".site_url($this->arrController."/hapus/id/".$r["departemenID"])."\" data-original-title=\"Hapus\">";
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