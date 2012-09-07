<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class References_instansi extends CI_Controller {
    
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
         
        $this->arrMenuConfig = array('SubModul'=>$submodulNama,'menu'=>$controllerSelected,'newInstansiID'=>$this->autonumber());
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

    private function autonumber(){
        return $this->conn->CIT_AUTONUMBER("tref_instansi", "instansiID", "I".date("Ymd"), 4);
    }
    
    public function index()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_instansi'
            , 'entries'=>array($this->grid_entries()) 
            , 'mode'=>'entry' 
            , 'listKota'=>  $this->loadKota() 
            , 'listPropinsi'=> $this->loadPrinsi()
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }

    public function loadPrinsi(){
       return $this->conn->CIT_SELECT('tref_propinsi');
    }
    
    public function loadByPropinsi(){
       $sql = $this->conn->CIT_SELECT('tref_city','equal', array('propinsiID'=>$_POST["propinsiID"]));
       $result = "";
       foreach ($sql as $value) {
           $result  .="<option value=\"".$value["kotaID"]."\">".$value["kotaNama"]."</option>";
       }
       $result = array('listKota'=>$result);
       echo json_encode($result);
    }
    
    public function loadKota(){
       return $this->conn->CIT_SELECT('tref_city');
    }

    function loadDefaultKota(){
       $rKota       = $this->conn->CIT_SELECT('tref_city');
       $result2     = "";
       foreach ($rKota as $n){
           $result2.="<option value=\"".$n["kotaID"]."\">".$n["kotaNama"]."</option>";
       }
       echo $result2;
    }
    function loadDefaultPropinsi(){
       $rKota       = $this->conn->CIT_SELECT('tref_propinsi');
       $result2     = "";
       foreach ($rKota as $n){
           $result2.="<option value=\"".$n["propinsiID"]."\">".$n["propinsiNama"]."</option>";
       }
       echo $result2;
    }
    private function fieldInsert($instansiID, $instansiNama, $alamat, $kotaID, $propinsiID, $kodePos, $nomorTelepon, $namaKontak, $jabatanKontak){
        return array('instansiID' => $instansiID 
            ,  'instansiNama' => $instansiNama
            , 'alamat' => $alamat
            ,  'kotaID'  => $kotaID
            ,  'propinsiID'  => $propinsiID
            ,  'kodePos'  => $kodePos
            ,  'nomorTelepon'  => $nomorTelepon
            ,  'namaKontak'  => $namaKontak
            ,  'jabatanKontak'  => $jabatanKontak
            );
    }
    
    private function fieldUpdate($instansiNama, $alamat, $kotaID, $propinsiID, $kodePos, $nomorTelepon, $namaKontak, $jabatanKontak){
        return array('instansiNama' => $instansiNama
            , 'alamat' => $alamat
            ,  'kotaID'  => $kotaID
            ,  'propinsiID'  => $propinsiID
            ,  'kodePos'  => $kodePos
            ,  'nomorTelepon'  => $nomorTelepon
            ,  'namaKontak'  => $namaKontak
            ,  'jabatanKontak'  => $jabatanKontak
            );
    }
    private function fieldWhere($instansiID){
        return array('instansiID' => $instansiID);
    }

    public function msg()
    {
        $activeModule = $this->session->userdata('setmodule');
        $data = array(
            'mainview' => $activeModule.'/view_'.$activeModule.'_instansi'
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
            
            //redirect($activeModule.'_instansi/msg/success', 'refresh');
            echo $hasil;
        }  else {
            echo $hasil;
            redirect($activeModule.'_instansi/msg/fail', 'refresh');
        }
    }
    
    public function hapus()
    {
         $activeModule   = $this->session->userdata('setmodule');
        $instansiID = $_POST["instansiID"];
        $r = $this->conn->CIT_DELETE('normal', 'tref_instansi', $this->fieldWhere($instansiID));
        $hasil = $r;
        if ($hasil == "OK"){
            redirect($activeModule.'_instansi/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_instansi/msg/fail', 'refresh');
        }
    }

    public function edit(){
        $sql = $this->conn->CIT_SELECT("tref_instansi", 'equal', array('instansiID'=>$_POST["instansiID"]));
        
        $result = array();
        foreach($sql as $r){
            array_push($result,array('instansiID' => $r["instansiID"] 
            ,  'instansiNama' => $r["instansiNama"]
            , 'alamat' => $r["alamat"]
            ,  'kotaID'  => $r["kotaID"]
            ,  'propinsiID'  => $r["propinsiID"]
            ,  'kodePos'  => $r["kodePos"]
            ,  'nomorTelepon'  => $r["nomorTelepon"]
            ,  'namaKontak'  => $r["namaKontak"]
            ,  'jabatanKontak'  => $r["jabatanKontak"]
            ));
        }
        echo json_encode($result);
        
    }
    
    public function entry()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        
        $listFieldEntry = $this->fieldInsert($_POST["instansiID"]
                , $_POST["instansiNama"]
                , $_POST["alamat"]
                , $_POST["kotaID"]
                , $_POST["propinsiID"]
                , $_POST["kodePos"]
                , $_POST["nomorTelepon"]
                , $_POST["namaKontak"]
                , $_POST["jabatanKontak"]);
        $i = $this->conn->CIT_INSERT("tref_instansi", $listFieldEntry);
        $hasil = $i;

        if ($hasil == "1"){
            redirect($activeModule.'_instansi/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_instansi/msg/fail', 'refresh');
        }
            //redirect($activeModule.'_instansi/msg/success', 'refresh');
            //echo $hasil;
    }
    
    public function update()
    {
        $activeModule   = $this->session->userdata('setmodule');
        $userLogin      = $this->session->userdata('username');
        $listFieldUpdate = $this->fieldUpdate($_POST["instansiNama"]
                , $_POST["alamat"]
                , $_POST["kotaID"]
                , $_POST["propinsiID"]
                , $_POST["kodePos"]
                , $_POST["nomorTelepon"]
                , $_POST["namaKontak"]
                , $_POST["jabatanKontak"]); 
        $whereID = $this->fieldWhere($_POST["instansiID"]);
        $i = $this->conn->CIT_UPDATE("tref_instansi", $listFieldUpdate,$whereID);
        $hasil=$i;
        if ($hasil == "1"){
            redirect($activeModule.'_instansi/msg/success', 'refresh');
            //echo $hasil;
        }  else {
           // echo $hasil;
            redirect($activeModule.'_instansi/msg/fail', 'refresh');
        }

    }
    
    function grid_entries()
    {
        $query  = $this->conn->CIT_SELECT('view_instansi');
        
        $table = "";
        $n = 1;
        foreach ($query as $r){
        $table .= "<tr>";
            $table .= "<td class=\"table-checkbox\"><input type=\"checkbox\" name=\"propinsiIDChecked[]\" id=\"propinsiIDChecked[]\" value=\"".$r["propinsiID"]."\" class=\"selectable-checkbox\"></td>";
            $table .= "<td>".$n."</td>";
            $table .= "<td>".$r["instansiNama"]."</td>";
            $table .= "<td>".$r["alamat"].", ".$r["kota"].", ".$r["propinsi"]."</td>";
            $table .= "<td>".$r["namaKontak"]."</td>";
            $table .= "<td>".$r["nomorTelepon"]."</td>";
            
            $table .= "<td>";
            $table .= "<a onclick=\"edit('".$r["instansiID"]."')\" class=\"btn btn-mini btn-square tip\" data-original-title=\"Edit\">";
            $table .= "<img alt=\"\" src=\"".base_url().ASSETS_IMAGES."icons/fugue/arrow-270.png\"/>";
            $table .= "</a>";
            $table .= "<a class=\"btn btn-mini btn-square tip\" onclick=\"hapus('".$r["instansiID"]."')\" data-original-title=\"Hapus\">";
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