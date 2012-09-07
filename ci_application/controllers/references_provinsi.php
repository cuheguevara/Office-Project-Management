<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class References_provinsi extends CI_Controller {
    
    private $arrMenuConfig;
    private $arrController;


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
            'mainview' => $activeModule.'/view_'.$activeModule.'_provinsi'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    public function msg()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_provinsi'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function hapusMultiple(){
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        $requestID      = $this->uri->segment(4);
        $PropID  = explode(',',$_REQUEST["propinsiID"]);
        for ($i = 0;$i<count($PropID);$i++){
            $sql_prep = "CALL sp_propinsi_delete(?,?,?,?)";
            $prep_param =array($PropID[$i],"Nama Propinsi",$_SERVER["REMOTE_ADDR"],$userLogin);
            $this->db->reconnect();
            $result    = $this->db->query($sql_prep,$prep_param,TRUE)->result();
            //var_dump($prep_param);
            foreach ($result as $value) {
                $hasil = $value->HASIL;
            }
            
        }
        
        if ($hasil == "OK"){
            
            //redirect($activeModule.'_provinsi/msg/success', 'refresh');
            echo $hasil;
        }  else {
            echo $hasil;
            redirect($activeModule.'_provinsi/msg/fail', 'refresh');
        }
    }
    
    public function hapus(){
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        $requestID      = $this->uri->segment(4);
        
        $sql_prep = "CALL sp_propinsi_delete(?,?,?,?)";
        $prep_param =array($requestID,"Nama Propinsi",$_SERVER["REMOTE_ADDR"],$userLogin);
        $result    = $this->db->query($sql_prep,$prep_param,TRUE)->result();
        
        foreach ($result as $value) {
            $hasil = $value->HASIL;
        }
        if ($hasil == "OK"){
            redirect($activeModule.'_provinsi/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_provinsi/msg/fail', 'refresh');
        }
    }


    public function entry()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        
        $propinsiNama = $_POST["propinsiNama"];
        $propinsiID = "ID";
        
        $sql_prep = "CALL sp_propinsi_insert(?,?,?,?)";
        $prep_param =array($propinsiID,$propinsiNama,$_SERVER["REMOTE_ADDR"],$userLogin);
        $result    = $this->db->query($sql_prep,$prep_param,TRUE)->result();
        foreach ($result as $value) {
            $hasil = $value->HASIL;
        }
        if ($hasil == "OK"){
            redirect($activeModule.'_provinsi/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_provinsi/msg/fail', 'refresh');
        }

    }
    
    public function update()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        
        $propinsiNama = $_POST["propinsiNama"];
        $propinsiID = $_POST["propinsiID"];
        
        $sql_prep = "CALL sp_propinsi_update(?,?,?,?)";
        $prep_param =array($propinsiID,$propinsiNama,$_SERVER["REMOTE_ADDR"],$userLogin);
        $result    = $this->db->query($sql_prep,$prep_param,TRUE)->result();
        foreach ($result as $value) {
            $hasil = $value->HASIL;
        }
        if ($hasil == "OK"){
            redirect($activeModule.'_provinsi/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_provinsi/msg/fail', 'refresh');
        }

    }
    
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('tref_propinsi');
        
        $table = "";
        $n = 1;
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"propinsiIDChecked[]\" id=\"propinsiIDChecked[]\" value=\"".$r["propinsiID"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["propinsiID"]."</td>";
            $table .= "<td>".$r["propinsiNama"]."</td>";
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["propinsiID"]."','".$r["propinsiNama"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a class=\"btn btn-mini btn-square tip\" href=\"".  site_url($this->arrController."/hapus/id/".$r["propinsiID"])."\" data-original-title=\"Hapus\">";
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