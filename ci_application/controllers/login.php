<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller {

	public function index()
	{
            //$activeModule = $this->session->userdata('setmodule');
            
            $this->load->view('login');
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */