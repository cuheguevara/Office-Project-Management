<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Json_support extends CI_Controller {
	private $conn;
	
	function __construct(){
		parent::__construct();
		$this->conn = new Citdbase();
	}
	
	public function loadKotaByPropinsi(){
		$sql = $this->conn->CIT_SELECT('tref_city','equal', array('propinsiID'=>$_REQUEST["propinsiID"]));
		$result = "";
		foreach ($sql as $value) {
			$result  .="<option value=\"".$value["kotaID"]."\">".$value["kotaNama"]."</option>";
		}
		$result = array('listKota'=>$result);
		echo json_encode($result);
	}
	
	public function loadBankCabangDefault(){
		$sql = $this->conn->CIT_SELECT('tref_bank_cabang');
		$result = "";
		foreach ($sql as $value) {
			$result  .="<option value=\"".$value["cabangID"]."\">".$value["cabangNama"]."</option>";
		}
		$result = array('list'=>$result);
		echo json_encode($result);
	}
	
	public function loadCabangByBank(){
		$sql = $this->conn->CIT_SELECT('tref_bank_cabang','equal', array('bankID'=>$_REQUEST["bankID"]));
		$result = "";
		if (count($sql)<1){
			$result = array('list'=>"kosong");
		}else{
			foreach ($sql as $value) {
				$result  .="<option value=\"".$value["cabangID"]."\">".$value["cabangNama"]."</option>";
			}
			$result = array('list'=>$result);
			
		}
		echo json_encode($result);
	}
	
}
?>