<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class References_kota extends CI_Controller {
    
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
            'mainview' => $activeModule.'/view_'.$activeModule.'_kota'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry'
            , 'listPropinsi'=> $this->loadPropinsi()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    private function fieldInsert($kotaID="",$propinsiID="",$kotaNama=""){
        return array("propinsiID"=>$propinsiID,"kotaNama"=>$kotaNama);
    }
    private function fieldUpdate($propinsiID="",$kotaNama=""){
        return array("propinsiID"=>$propinsiID,"kotaNama"=>$kotaNama);
    }
    private function fieldWhere($kotaID=""){
        return array("kotaID"=>$kotaID);
    }


    public function loadPropinsi()
    {
    	return $this->conn->CIT_SELECT('tref_propinsi');
    }
    
    public function msg()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_kota'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
        	
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
    
    public function hapusMultiple()
    {
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
            
            //redirect($activeModule.'_bank/msg/success', 'refresh');
            echo $hasil;
        }  else {
            echo $hasil;
            redirect($activeModule.'_bank/msg/fail', 'refresh');
        }
    }
    
    public function hapus()
    {
        $r = $this->conn->CIT_DELETE('normal', 'tref_city', array("kotaID"=>$_POST["kotaID"],"propinsiID"=>$_POST["propinsiID"]));
        echo $r;
//        if ($r == 1){
//            redirect($this->arrController.'/msg/success', 'refresh');
//        }  else {
//            redirect($this->arrController.'/msg/fail', 'refresh');
//        }
    }

    public function entry()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        
        $r = $this->conn->CIT_INSERT("tref_city", $this->fieldInsert($_POST["kotaID"], $_POST["propinsiID"], $_POST["kotaNama"]));
        $hasil = $r;
        
        if ($hasil == "OK"){
            redirect($activeModule.'_kota/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_kota/msg/fail', 'refresh');
        }

    }
    
    public function update()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        
        $listFieldUpdate = $this->fieldUpdate($_POST["propinsiID"], $_POST["kotaNama"]); 
        $whereID = $this->fieldWhere($_POST["kotaID"]);
        $i = $this->conn->CIT_UPDATE("tref_city", $listFieldUpdate,$whereID);
        $hasil = $i;
        if ($hasil == "OK"){
            redirect($activeModule.'_kota/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_kota/msg/fail', 'refresh');
        }

    }
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('view_kota');
        
        $table = "";
        $n = 1;
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"fieldID[]\" id=\"fieldID[]\" value=\"".$r["kotaID"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["propinsiNama"]."</td>";
            $table .= "<td>".$r["kotaNama"]."</td>";
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["kotaID"]."','".$r["propinsiID"]."','".$r["kotaNama"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a onclick=\"hapus('".$r["kotaID"]."','".$r["propinsiID"]."')\" class=\"btn btn-mini btn-square tip\"  data-original-title=\"Hapus\">";
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