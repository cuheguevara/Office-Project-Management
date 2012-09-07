<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Authentication extends CI_Controller {
    
    function __construct(){
    	parent::__construct();
        $this->conn = new Citdbase();
        $logged = $this->session->userdata('username');
        
        $activeModule = $this->session->userdata('setmodule');

    }
    
    public function index()
    {
        $username = $this->input->post('auth-email-user');
        $password = $this->input->post('auth-password');
        $remember = $this->input->post('remember');
        
        $sql       = "call sp_GetUserByUserNameAndPassword(?,?)";
        $result    = $this->db->query($sql, array($username,$password),TRUE)->result();
        if (count($result) > 0){
            $session_handler = array();
            foreach ($result as $row) {
               $session_handler= array(
                    'levelID' => $row->levelID
                    , 'nip'     => $row->nip
                    , 'username'     => $row->username
                    , 'password'     => md5($row->password)
                    , 'levelName'     => md5($row->levelName)
                    , 'userID'     => $row->userID
                    , 'namalengkap'     => $row->namalengkap
                    , 'namapanggilan'     => $row->namapanggilan
                );
            }
            
            //$this->db->next_result(); // Dump the extra resultset.
                        
            $this->session->set_userdata($session_handler);
            redirect("dashboard", "refresh");
            
        }else{
            redirect("login", "refresh");
            
        }
    }
    
    public function logout()
    {
        $this->load->library('session');
        $session_handler= array(
                    'levelID' => ''
                    , 'nip'     => ''
                    , 'username'     => ''
                    , 'password'     => ''
                    , 'levelName'     => ''
                    , 'userID'     => ''
                    , 'namalengkap'     => ''
                    , 'namapanggilan'     => ''
                    , 'setmodule'     => ''
                );
        $this->session->unset_userdata($session_handler);
        $this->session->sess_destroy();
        sleep(5);
        redirect("login", "refresh");
    }
    
    public function changemodule()
    {
        $this->load->library('session');
        $session_handler= array(
                    'setmodule'     => ''
                );
        $this->session->unset_userdata($session_handler);
        //$this->session->sess_destroy();
        sleep(5);
        redirect("setmodule", "refresh");
    }
}
        

/* End of file authentication.php */
/* Location: ./application/controllers/welcome.php */