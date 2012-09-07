<?php
    $activeModule = $this->session->userdata('setmodule');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $("#propinsiID").change(function(){
            if ($(this).val()=="*"){
                $.post("references_instansi/loadDefaultKota", {
                    
                }, function(e){
                    $('<option value=\'*\' selected>Pilih Kota</option>').appendTo("#kotaID");
                    $("#kotaID").html("");
                    $(e).appendTo("#kotaID");
                });
                
            }else{
                $.getJSON("references_instansi/loadByPropinsi", {
                    propinsiID : $(this).val()
                }, function(e){
                    //$('<option value=\'*\' selected>*</option>').appendTo("#kode_stok");
                    $("#kotaID").html("");
                    $(e.listKota).appendTo("#kotaID");
                }, 'json');
                
            }
        }); 
    });
    
    function DefaultKotaPropinsi(){
        $.post("references_instansi/loadDefaultPropinsi", {}, function(e){
            $('<option value=\'*\' selected>Pilih Propinsi</option>').appendTo("#propinsiID");
            $("#propinsiID").html("");
            $(e).appendTo("#propinsiID");
        });
        $.post("references_instansi/loadDefaultKota", {}, function(e){
            $('<option value=\'*\' selected>Pilih Kota</option>').appendTo("#kotaID");
            $("#kotaID").html("");
            $(e).appendTo("#kotaID");
        });
    }
                
    
    function hapus(id){
        $.post("<?php echo site_url($activeModule.'_instansi/hapus'); ?>", {
            instansiID:id
        }, function(e){

        });
    
    }
    function edit(id){
        DefaultKotaPropinsi();
//        setInterval("", 2000);
        $.post("<?php echo site_url($activeModule.'_instansi/edit'); ?>", {
            instansiID:id
        }, function(e){
            $("#instansiID").val(e[0].instansiID); 
            $("#instansiNama").val(e[0].instansiNama); 
            $("#alamat").val(e[0].alamat); 
            $("#kotaID").val(e[0].kotaID); 
            $("#propinsiID").val(e[0].propinsiID); 
            $("#kodePos").val(e[0].kodePos); 
            $("#nomorTelepon").val(e[0].nomorTelepon); 
            $("#namaKontak").val(e[0].namaKontak); 
            $("#jabatanKontak").val(e[0].jabatanKontak); 
            $("#myform").attr("action","<?php echo site_url($activeModule.'_instansi/update'); ?>");
        }, "json");
    
    }
    function deleteChecked(){
        var checked = []
        $("input[name='propinsiIDChecked[]']:checked").each(function ()
        {
            checked.push(parseInt($(this).val()));
        });
        $.ajax({
            type: "POST",
            url: '<?php echo site_url($activeModule.'_provinsi/hapusMultiple'); ?>',
            dataType: 'html',
            data: 'propinsiID='+checked,
            success: function(data){
                if (data=="OK"){
                    window.location.href = "<?php echo site_url("references_provinsi/msg/success"); ?>";
                }else{
                    window.location.href = "<?php echo site_url("references_provinsi/msg/fail"); ?>";
                }
                    
            }
        });
        return false;
    }
</script>
<div class="row-fluid">
    <div class="span12">
        <div class="box">
            <div class="box-head">
                <h3>FORM INPUT</h3>
            </div>
            <div class="box-content">
                <?php
                    $msg = $this->uri->segment(3);
                    
                    if ( ($msg=="") || (!isset($msg)) || (empty ($msg)) ){
                        
                    }else if((isset($msg)) || (!empty ($msg)) ) :
                        switch ($msg){
                            case "success" : $alert="alert-info"; $msg = "Proses Berhasil Dilakukan"; break;
                            case "fail" : $alert="alert-error"; $msg = "Terjadi Kegagalan Proses"; break;
                        }
                        ?>
                            <div class="alert <?php echo $alert;?> alert-block" id="alert"><a class="close" data-dismiss="alert" href="#">&nbsp;</a><h4 class="alert-heading"><?php echo $msg;?>!</h4></div>
                        <?php
                    endif;
                ?>
                <!-- FORMS  -->
                <div id="element_set">
                    
                    <form id="myform" class="form-horizontal" method="post" action="<?php echo site_url($activeModule.'_instansi/'.$mode); ?>">
                        <span class="span6">
                            <div class="control-group">
                                <label class="control-label" for="disabled">Instansi ID</label>      
                                <div class="controls">
                                    <input type="text" class="input-square" readonly="" id="instansiID" name="instansiID" value="<?php echo $newInstansiID;?>"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="basicround">Nama Instansi</label>
                                <div class="controls">
                                    <input type="text" class="input-square" id="instansiNama" name="instansiNama"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="basicround">Nama Kontak </label>                  
                                        <div class="controls">
                                                <input type="text" class="input-square" id="namaKontak" name="namaKontak"/>
                                        </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Jabatan </label>
                                    <div class="controls">
                                        <input type="text" class="input-square" id="jabatanKontak" name="jabatanKontak"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Nomor Telepon </label>
                                    <div class="controls">
                                        <input type="text" class="input-square" id="nomorTelepon" name="nomorTelepon"/>
                                    </div>
                                </div>
                        </span>    
                        <span class="span6">
                            <div class="control-group">
                                <label for="basicround" class="control-label">Alamat </label>
                                <div class="controls">
                                    <input type="text" class="span12 input-square" id="alamat" name="alamat"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label for="select" class="control-label">Propinsi</label>
                                <div class="controls">
                                    <select name="propinsiID" id="propinsiID">
                                        <option value="*" selected>Pilih Propinsi</option>
                                        <?php foreach ($listPropinsi as $r): ?>
                                            <option value="<?php echo $r["propinsiID"]; ?>"><?php echo $r["propinsiNama"]; ?></option>
                                        <?php endforeach;?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label for="select" class="control-label">Kota</label>
                                <div class="controls">
                                    <select name="kotaID" id="kotaID">
                                        <option value="*" selected>Pilih Kota</option>
                                        <?php foreach ($listKota as $r): ?>
                                            <option value="<?php echo $r["kotaID"]; ?>"><?php echo $r["kotaNama"]; ?></option>
                                        <?php endforeach;?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="basicround">Kodepos </label>
                                <div class="controls">
                                <input type="text" name="kodePos" id="kodePos" class="input-square"/>
                                </div>
                            </div>
                        </span>    

                        <div class="row-fluid">
                            <div class="span12">
                                <div class="form-actions">
                                    <input type="submit" value="Simpan" class="btn btn-primary"/>
                                    <input type="Reset" value="Reset" class="btn btn-danger"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- FORMS  -->
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span12">
        <div class="box">
            <div class="box-head">
                <h3>Data Provinsi</h3>
                <div class="actions">
                    <ul>
                        <li>
                            <a id="hapus" onclick="deleteChecked();" class="btn btn-mini btn-square tip" href="#" data-original-title="Hapus Data Terpilih"><img alt="" src="<?php echo base_url().ASSETS_IMAGES; ?>icons/fugue/cross.png"/> Delete Checked</a>
                        </li>
                        <li>
                            <a class="btn btn-mini btn-square tip" href="#" data-original-title="Cetak Daftar Propinsi"><img alt="" src="<?php echo base_url().ASSETS_IMAGES; ?>icons/fugue/printer.png"/> Print table</a>
                        </li>
                    </ul>	
                </div>
            </div>

            <div class="box-content box-nomargin">
                <!-- ISI //-->
                <div class="tab-pane active" id="basic">
                    <table class='table table-striped dataTable table-bordered'>
                        <thead>
                            <tr>
                                <th class="table-checkbox"><input type="checkbox" class="sel_all"></th>
                                <th>No</th>
                                <th>Nama</th>
                                <th>Alamat</th>
                                <th>Nama Kontak</th>
                                <th>No Telepon</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            {entries}
                            {content}
                            {/entries}
                        </tbody>
                    </table>
                </div>
                <!-- ISI //-->
            </div>
        </div>
    </div>
</div>