<?php
    $activeModule = $this->session->userdata('setmodule');
?>
<script type="text/javascript">
    function edit(id,nama){
        $("#jabatanID").val(id);
        $("#jabatanNama").val(nama);
        $("#myform").attr("action","<?php echo site_url($activeModule.'_jabatan/update'); ?>");
    }
    function deleteChecked(){
        var checked = []
        $("input[name='field[]']:checked").each(function ()
        {
            checked.push(parseInt($(this).val()));
        });
        $.ajax({
            type: "POST",
            url: '<?php echo site_url($activeModule.'_jabatan/hapusMultiple'); ?>',
            dataType: 'html',
            data: 'jabatanID='+checked,
            success: function(data){
                if (data=="OK"){
                    window.location.href = "<?php echo site_url("references_jabatan/msg/success"); ?>";
                }else{
                    window.location.href = "<?php echo site_url("references_jabatan/msg/fail"); ?>";
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
            	<ul class="nav nav-tabs">
					<li class='active'><a href="#0" data-toggle="tab">Active Tab</a></li>
					<li><a href="#1" data-toggle="tab">Inctive Tab</a></li>
					<li><a href="#2" data-toggle="tab">Inctive Tab #2</a></li>
				</ul>
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
                <form id="myform" class="form-horizontal" method="post" action="<?php echo site_url($activeModule.'_jabatan/'.$mode); ?>">
	            	<div class="tab-content">
						<div class="tab-pane active" id="0">
							<span class="span6">
								<div class="control-group">
			                        <label class="control-label" for="basicround">NIP</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="nip" name="nip"/>
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label class="control-label" for="basicround">NPWP</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="npwp" name="npwp"/>
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label class="control-label" for="basicround">No. KTP/SIM</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="noKTPSIM" name="noKTPSIM"/>
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label class="control-label" for="basicround">No. JAMSOSTEK</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="noJamsostek" name="noJamsostek"/>
			                        </div>
			                    </div>
							</span>
							<span class="span6">
								<div class="control-group">
			                        <label class="control-label" for="basicround">Nama Lengkap</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="namaLengkap" name="namaLengkap"/>
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label class="control-label" for="basicround">Nama Panggilan</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="namaPanggilan" name="namaPanggilan"/>
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label class="control-label" for="basicround">Nama Panggilan</label>
			                        <div class="controls">
			                            <input type="text" class="input-square" id="namaPanggilan" name="namaPanggilan"/>
			                        </div>
			                    </div>
			                    <div class="control-group">
										<label class="control-label" for="datepicker">Tanggal Lahir</label>
										<div class="controls">
											<input type="text" class="datepick" id="tanggalLahir" name="tanggalLahir">
										</div>
									</div>
									<div class="control-group">
                                <label for="select" class="control-label">Tempat Lahir (Kota)</label>
                                <div class="controls">
                                    <select name="kotaID" id="kotaID">
                                        <option value="*" selected>Pilih Kota</option>
                                        <?php 
                                        $conn = new Citdbase();
                                        $listKota = $conn->CIT_SELECT("tref_city");
                                        foreach ($listKota as $r): 
                                        ?>
                                            <option value="<?php echo $r["kotaID"]; ?>"><?php echo $r["kotaNama"]; ?></option>
                                        <?php endforeach;?>
                                    </select>
                                </div>
                            </div>
							</span>
						</div>
						
						<div class="tab-pane" id="1">
							
						</div>
						
						<div class="tab-pane" id="2">
							<span class="span6">
							
							</span>
						</div>
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
                            <a class="btn btn-mini btn-square tip" href="#" data-original-title="Cetak Daftar jabatan"><img alt="" src="<?php echo base_url().ASSETS_IMAGES; ?>icons/fugue/printer.png"/> Print table</a>
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