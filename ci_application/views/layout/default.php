<?php
$modulActive    = $this->session->userdata('setmodule');
if (empty ($modulActive)){
    $text = "";
}else{
    
}
?>
<!doctype html>
<html lang="en">
<head>
    <script src="<?php echo base_url().ASSETS_JS; ?>jquery.js"></script>
    <?php echo $this->load->view(LAYOUT_PATH.'layout-header'); ?>
</head>
<body>
<div class="topbar">
    <?php echo $this->load->view(LAYOUT_PATH.'layout-topbar'); ?>
	
</div>
<div class="breadcrumbs">
	<div class="container-fluid">
		<ul class="bread pull-left">
			<li>
				<a href="<?php echo site_url("authentication/changemodule"); ?>"><i class="icon-home icon-white"></i></a>
			</li>
			<li>
				<a href="<?php echo site_url($modulActive); ?>">
					<?php echo $modulActive; ?>
				</a>
			</li>
		</ul>

	</div>
</div>
<div class="main">
	
            <?php
            if ( (trim($modulActive) == "") || (empty ($modulActive)) ) {
                //echo $this->load->view('admin-template/navbar-left'); 
            }else{
                echo $this->load->view(LAYOUT_PATH.'layout-navbar'); 
            }
            ?>
        
	<div class="container-fluid">
		<div class="content">
                    <?php echo $this->load->view($mainview); ?>
                </div>	
	</div>
</div>	
<?php echo $this->load->view(LAYOUT_PATH.'layout-footer'); ?>
</body>
</html>