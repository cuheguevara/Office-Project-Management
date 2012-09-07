<?php
    $modulActive = $this->session->userdata('setmodule');
    $conn       = new Citdbase();
    $moduleID   = $conn->CIT_GETSOMETHING("modulID", "conf_modul", array('modulPage_Form_Controller'=>$modulActive));
    $listSubModule = $conn->CIT_SELECT("conf_submodul", 'equal', array('modulID'=>$moduleID,'is_aktif'=>'Y'));
    ?>
<div class="navi">
    <ul class='main-nav'>
        <li class='active'>
            <a href="<?php echo site_url($modulActive); ?>" class='light'>
                        <div class="ico"><i class="icon-home icon-white"></i></div>
                        Modul <?php echo ucfirst($modulActive); ?>
                        <span class="label label-warning">10</span>
                </a>
        </li>
        <?php
        foreach ($listSubModule as $recListSubModule) :
            if ($SubModul == $recListSubModule["submodulNama"]){
                $class_open = "active open";
                $subclass_open = "collapsed-nav";
            }else{
                $class_open = "";
                $subclass_open = "collapsed-nav closed";
                
            }
        ?>
        <li class="<?php echo $class_open; ?>">
                <a href="#" class='light toggle-collapsed'>
                        <div class="ico"><i class="icon-th-large icon-white"></i></div>
                        <?php echo $recListSubModule["submodulNama"]; ?>
                        <img src="<?php echo base_url().ASSETS_IMAGES; ?>/toggle-subnav-down.png" alt=""/>
                </a>
                <ul class='<?php echo $subclass_open; ?>'>
                <?php 
                    $listMenu = $conn->CIT_SELECT("conf_menu", 'equal', array('subModulID'=>$recListSubModule["submodulID"],'is_aktif'=>'Y'));
                    foreach ($listMenu as $rListMenu):
                        if ($menu == $rListMenu["controller"]){
                            $menu_active = "active";
                        }else{
                            $menu_active = "";
                            
                        }
                ?>
                    <li class="<?php echo $menu_active;?>"><a href="<?php echo site_url($modulActive.'_'.$rListMenu["controller"]); ?>"><?php echo $rListMenu["menuNama"]; ?></a></li>
                <?php 
                    endforeach;
                ?>
                </ul>
            </li>
        <?php
        endforeach;
        ?>
            
<!--            
        
        
        <li>
                <a href="forms.html" class='light'>
                        <div class="ico"><i class="icon-list icon-white"></i></div>
                        Forms
                        <span class="label label-info">1</span>
                </a>
        </li>
        <li>
                <a href="#" class='light toggle-collapsed'>
                        <div class="ico"><i class="icon-th-large icon-white"></i></div>
                        Tables
                        <img src="<?php echo base_url().ASSETS_IMAGES; ?>/toggle-subnav-down.png" alt=""/>
                </a>
                <ul class='collapsed-nav closed'>
                        <li>
                                <a href="datatables.html">
                                        Data Tables
                                </a>
                        </li>
                        <li>
                                <a href="plaintables.html">
                                        Plain Tables
                                </a>
                        </li>
                        <li>
                                <a href="mediatables.html">
                                        Media Tables
                                </a>
                        </li>
                </ul>
        </li>
    
			<li>
				<a href="#" class='light toggle-collapsed'>
					<div class="ico"><i class="icon-tasks icon-white"></i></div>
					Interface Elements
					<img src="<?php echo base_url().ASSETS_IMAGES; ?>/toggle-subnav-down.png" alt=""/>
				</a>
				<ul class='collapsed-nav closed'>
					<li>
						<a href="buttons.html">
							Buttons & Icons
						</a>
					</li>
					<li>
						<a href="sliders.html">
							Sliders & Progress-Bars
						</a>
					</li>
					<li>
						<a href="tooltips.html">
							Tooltips, Alerts & Notification
						</a>
					</li>
					<li>
						<a href="tabs.html">
							Tabs, Pills & Accordion
						</a>
					</li>
				</ul>
			</li>
			<li>
				<a href="statistics.html" class='light'>
					<div class="ico"><i class="icon-signal icon-white"></i></div>
					Statistics
					<span class="label label-important">3</span>
				</a>
			</li>
			<li>
				<a href="#" class='light toggle-collapsed'>
					<div class="ico"><i class="icon-exclamation-sign icon-white"></i></div>
					Error Pages
					<img src="<?php echo base_url().ASSETS_IMAGES; ?>/toggle-subnav-down.png" alt=""/>
				</a>
				<ul class='collapsed-nav closed'>
					<li>
						<a href="403.html">
							403
						</a>
					</li>
					<li>
						<a href="404.html">
							404
						</a>
					</li>
					<li>
						<a href="500.html">
							500
						</a>
					</li>
				</ul>
			</li>
			<li>
				<a href="#" class='light toggle-collapsed'>
					<div class="ico"><i class="icon-book icon-white"></i></div>
					Sample Pages
					<img src="<?php echo base_url().ASSETS_IMAGES; ?>/toggle-subnav-down.png" alt=""/>
				</a>
				<ul class='collapsed-nav closed'>
					<li>
						<a href="gallery.html">
							Gallery
						</a>
					</li>
					<li>
						<a href="messages.html">
							Messages
						</a>
					</li>
					<li>
						<a href="userprofile.html">
							User Profile
						</a>
					</li>
					<li>
						<a href="index.html">
							Login
						</a>
					</li>
					<li>
						<a href="results.html">
							Search results
						</a>
					</li>
				</ul>
			</li>-->
		</ul>
</div>
	