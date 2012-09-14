<?php
    $activeModule = $this->session->userdata('setmodule');
?>
<script src="<?php echo base_url().ASSETS_JS; ?>functionset.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        
    	$("#besarTHP").ForceNumericOnly();
    	$("#nip").change(function(){
            $.post("human_resources_penerimaan/getKaryawan",{
                nip:$(this).val()
            },function (e){
                $("#nama").val(e[0].namaLengkap);
                $("#alamat").val(e[0].alamat);
                $("#kota").val(e[0].kota);
                $("#kodepos").val(e[0].kodePos);
                $("#propinsi").val(e[0].propinsi);
            },"json");
        });
    });

    function edit(id,nama){
        $("#jabatanID").val(id);
        $("#jabatanNama").val(nama);
        $("#myform").attr("action","<?php echo site_url($activeModule.'_jabatan/update'); ?>");
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
            url: '<?php echo site_url($activeModule.'_karyawan/hapusMultiple'); ?>',
            dataType: 'html',
            data: 'nip='+checked,
            success: function(data){
                
                if (data==1){
                    window.location.href = "<?php echo site_url($activeModule."_karyawan/msg/success"); ?>";
                }else{
                    window.location.href = "<?php echo site_url($activeModule."_karyawan/msg/fail"); ?>";
                }
                    
            }
        });
        return false;
    }
</script>
<div class="row-fluid">
    <div class="span12">
        <div class="box">
            <div class="box-head tabs">
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
                <form id="myform" class="form-horizontal" method="post" action="<?php echo site_url($activeModule.'_penerimaan/'.$mode); ?>">
                    <!-- FORMS  -->
                    <div class="span6">
                        <fieldset>
                            <legend>Data Karyawan</legend>
                            <div class="control-group">
                                    <label for="selsear" class="control-label">Select with search</label>
                                    <div class="controls">
                                        <select name="nip" id="nip" class='cho'>
                                            <?php echo $listKaryawan;?>
                                        </select>
                                    </div>
                            </div>
                            <fieldset>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Nama Lengkap </label>
                                    <div class="controls">
                                        <input type="text" readonly="" class="input-square" placeholder="Nama Lengkap" id="nama" name="nama"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Alamat</label>
                                    <div class="controls">
                                        <input type="text" readonly="" class="input-square" placeholder="Alamat" id="alamat" name="alamat"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Kota</label>
                                    <div class="controls">
                                        <input type="text" readonly="" class="input-square" placeholder="Kota" id="kota" name="kota"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Kode Pos</label>
                                    <div class="controls">
                                        <input type="text" readonly="" class="input-square" placeholder="Kodepos" id="kodepos" name="kodepos"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Propinsi</label>
                                    <div class="controls">
                                        <input type="text" readonly="" class="input-square" placeholder="Propinsi" id="propinsi" name="propinsi"/>
                                    </div>
                                </div>
                                
                            </fieldset>
                        </fieldset>
                    </div>
                    <div class="span6">
                        <fieldset>
                            <legend>Management</legend>
                            <div class="control-group">
                                    <label for="selsear" class="control-label">Departemen</label>
                                    <div class="controls">
                                        <select name="departemenID" id="departemenID" class='cho'>
                                            <?php echo $listDepartment;?>
                                        </select>
                                    </div>
                            </div>
                            <div class="control-group">
                                    <label for="selsear" class="control-label">Jabatan</label>
                                    <div class="controls">
                                        <select name="jabatanID" id="jabatanID" class='cho'>
                                            <?php echo $listJabatan;?>
                                        </select>
                                    </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="datepicker">Periode Awal</label>
                                <div class="controls">
                                        <input type="text" class="datepick" id="periodeAwal" name="periodeAwal"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="datepicker">Periode Akhir</label>
                                <div class="controls">
                                        <input type="text" class="datepick" id="periodeAkhir" name="periodeAkhir"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="basicround">Gaji Pokok</label>
                                <div class="controls">
                                    <input type="text" class="input-square" placeholder="Besar THP" id="besarTHP" name="besarTHP"/>
                                </div>
                            </div>
                            <div class="control-group">
                                    <label for="select" class="control-label">Periode Pembayaran</label>
                                    <div class="controls">
                                        <select name="jenisGaji" id="jenisGaji">
                                            <option value="*" selected>Periode Pembayaran</option>
                                            <option value="Perbulan">Bulanan</option>
                                            <option value="Perhari">Harian</option>
                                        </select>
                                    </div>
                                </div>
                        </fieldset>
                    </div>
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

<!--<div class="row-fluid">
    <div class="span12">
        <div class="box">
            <div class="box-head">
                <h3>Data Karyawan</h3>
                <div class="actions">
                    <ul>
                        <li>
                            <a id="hapus" onclick="deleteChecked();" class="btn btn-mini btn-square tip" href="javascript:void(0);" data-original-title="Hapus Data Terpilih"><img alt="" src="<?php echo base_url().ASSETS_IMAGES; ?>icons/fugue/cross.png"/> Delete Checked</a>
                        </li>
                        <li>
                            <a class="btn btn-mini btn-square tip" href="#" data-original-title="Cetak Daftar jabatan"><img alt="" src="<?php echo base_url().ASSETS_IMAGES; ?>icons/fugue/printer.png"/> Print table</a>
                        </li>
                    </ul>	
                </div>
            </div>

            <div class="box-content box-nomargin">
                 ISI //
                <div class="tab-pane active" id="basic">
                    <table class='table table-striped dataTable table-bordered'>
                        <thead>
                            <tr>
                                <th class="table-checkbox"><input type="checkbox" class="sel_all"></th>
                                <th>No</th>
                                <th>NIP</th>
                                <th>Nama</th>
                                <th>Alamat</th>
                                <th>Email</th>
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
                 ISI //
            </div>
        </div>
    </div>
</div>-->