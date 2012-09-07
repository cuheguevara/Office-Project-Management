<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class References extends CI_Controller {
    
     private $arrMenuConfig;
    
    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        $this->load->library('session');
        $logged = $this->session->userdata('username');
        $activeModule = $this->session->userdata('setmodule');
        
        $this->arrMenuConfig = array('SubModul'=>'','menu'=>'');
         
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
            'mainview' => $activeModule.'/view_index'
        );
        $this->parser->parse(LAYOUT_PATH.'default',array_merge ($data,  $this->arrMenuConfig));
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */