<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dashboard extends CI_Controller {
    
    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        $this->load->library('session');
        $logged = $this->session->userdata('username');
        $activeModule = $this->session->userdata('select-module');
        if ((!isset($logged)) || ( empty ($logged) )){ redirect('login','refresh'); }else{ 
            if (!(isset($activeModule)) || ($activeModule=='')){ redirect('setmodule',''); }else{ 
                
            }
        }
    }
    
    public function index()
    {
//        $dataview = array();
//        $this->parser->parse(LAYOUT_PATH.'default',$dataview);
//        $this->load->view(APP_VIEW_PREFIX.'dashboard');
    }
}
        

/* End of file authentication.php */
/* Location: ./application/controllers/welcome.php */