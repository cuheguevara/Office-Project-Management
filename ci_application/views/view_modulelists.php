<div class="row-fluid no-margin">
    <div class="span12">
        <ul class="quicktasks">
            <?php
            $activeModule = $this->session->userdata('select-module');
            foreach($module_lists as $modListsRecord):
            ?>
            <li>
                <a href="<?php echo site_url("setmodule/setmodid".$activeModule."/".$modListsRecord->modulPage_Form_Controller); ?>">
                            <img src="<?php echo base_url().ASSETS_IMAGES;?>icons/essen/32/<?php echo $modListsRecord->picture; ?>" alt=""/>
                            <span><?php echo $modListsRecord->modulNama; ?></span>
                    </a>
            </li>
            <?php
            endforeach;
            ?>
        </ul>
    </div>
</div>