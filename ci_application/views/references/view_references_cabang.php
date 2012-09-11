<?php
    $activeModule = $this->session->userdata('setmodule');
?>
<script src="<?php echo base_url().ASSETS_JS; ?>functionset.js"></script>
<script type="text/javascript">
    function validate_form(){
        var valid=true;
        if ($("#modalPropinsiID").val()=="*"){
            alert("pilih Propinsi");
            return false;
        }
        if ($("#modalKotaID").val()=="*"){
            alert("pilih Propinsi");
            return false;
        }
        if ($("#modalBankID").val()=="*"){
            alert("pilih Propinsi");
            return false;
        }
        return valid;
    }
    function edit(cabangID,bankID){
        $.post("<?php echo site_url($activeModule.'_cabang/getCabang'); ?>",{
            cabangID : cabangID
            , bankID : bankID
        },function(e){
            $("#cabangID").val(e[0].cabangID)
            $("#cabangNama").val(e[0].cabangNama)
            $("#modalAlamat").val(e[0].modalAlamat)
            $("#modalBankID").val(e[0].modalBankID)
            $("#modalEmail").val(e[0].modalEmail)
            $("#modalFax").val(e[0].modalFax)
            $("#modalKodePos").val(e[0].modalKodePos)
            $("#modalKotaID").val(e[0].modalKotaID)
            $("#modalNamaKontak").val(e[0].modalNamaKontak)
            $("#modalPropinsiID").val(e[0].modalPropinsiID)
            $("#modalTelepon").val(e[0].modalTelepon)
        },"json");
        $("#myform").attr("action","<?php echo site_url($activeModule.'_cabang/update'); ?>");
    }
    function deleteChecked(){
        var checked = []
        $("input[name='fieldID[]']:checked").each(function ()
        {
           if(isNaN($(this).val())){
                checked.push($(this).val())
            }else{
                checked.push(parseInt($(this).val()));
            }
        });
        $.ajax({
            type: "POST",
            url: '<?php echo site_url($activeModule.'_cabang/hapusMultiple'); ?>',
            dataType: 'html',
            data: 'cabangID='+checked,
            success: function(data){
                if (data=="1"){
                    window.location.href = "<?php echo site_url($activeModule."_cabang/msg/success"); ?>";
                }else{
                    window.location.href = "<?php echo site_url($activeModule."_cabang/msg/fail"); ?>";
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
                        
                    }else if((isset($msg)) || (empty ($msg)) ) :
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
                <form id="myform" class="form-horizontal" onsubmit="return validate_form ();" method="post" action="<?php echo site_url($activeModule.'_cabang/'.$mode); ?>">
                    <span class="span6">
                        <div class="control-group">
                            <label for="select" class="control-label">Bank</label>
                            <div class="controls">
                                <select name="modalBankID" id="modalBankID">
                                    <option value="*" selected>Pilih Bank</option>
                                    <?php foreach ($listBank as $r): ?>
                                        <option value="<?php echo $r["bankID"]; ?>"><?php echo $r["bankName"]; ?>( <?php echo $r["bankFullName"]; ?> )</option>
                                    <?php endforeach;?>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="basicround">Nama Cabang</label>
                            <div class="controls">
                                <input type="text" class="input-square" id="cabangID" name="cabangID"/>
                                <input type="text" class="input-square" id="cabangNama" name="cabangNama"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="basicround">Nama Kontak </label>
                            <div class="controls">
                                <input type="text" name="modalNamaKontak" id="modalNamaKontak" class="input-square"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="basicround">Telepon</label>
                            <div class="controls">
                                <input type="text" name="modalTelepon" id="modalTelepon" class="input-square"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="basicround">Fax</label>
                            <div class="controls">
                                <input type="text" name="modalFax" id="modalFax" class="input-square"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="basicround">Email</label>
                            <div class="controls">
                                <input type="text" name="modalEmail" id="modalEmail" class="input-square"/>
                            </div>
                        </div>
                    </span>
                    <span class="span6">
                        <div class="control-group">
                            <label class="control-label" for="basicround">Alamat</label>
                            <div class="controls">
                                <input type="text" class="span6 input-square" id="modalAlamat" name="modalAlamat"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="select" class="control-label">Propinsi</label>
                            <div class="controls">
                                <select name="modalPropinsiID" id="modalPropinsiID">
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
                                <select name="modalKotaID" id="modalKotaID">
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
                                <input type="text" name="modalKodePos" id="modalKodePos" class="span2 input-square"/>
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
                                <th>Nama Bank</th>
                                <th>Nama Cabang</th>
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