<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Setmodule extends CI_Controller {
        
    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        $this->load->library('session');
        
        $logged = $this->session->userdata('username');
        
        $activeModule = $this->session->userdata('setmodule');
        if ((!isset($logged)) || ($logged=='')){ redirect('login','refresh'); 
        
        }else{ 
            if ((!isset($activeModule)) || ($activeModule=='')){ 
                $this->user_login = $this->session->userdata('username');
            }else{
                //echo $activeModule;
                redirect($activeModule,'');
                //redirect('dashboard','');
            }
        }
    }
    
    public function index(){
        $sql       = "call sp_GetModuleAuthenticationByUsername(?)";
        $result    = $this->db->query($sql, array($this->user_login),TRUE)->result();
        $data   =   array(
            'module_lists'=>$result
            , 'mainview'=>APP_VIEW_PREFIX.'modulelists'
            );
        $this->parser->parse(LAYOUT_PATH.'default',$data);
        //$this->load->view('admin-template/default');
        
    }
    
    public function setmodid(){
        $modulName = $this->uri->segment(3);
        $redirect = $this->conn->CIT_GETSOMETHING('link', 'conf_modul', array("modulNama"=>$modulName));
        $user_data=array("setmodule"=>$modulName);
        $this->session->set_userdata($user_data);
        redirect($modulName, "refresh");
        //print_r($this->session->userdata);
        //echo $modulName;
    }
        
}

/* End of file Dashboard.php */
/* Location: ./application/controllers/dashboard.php */