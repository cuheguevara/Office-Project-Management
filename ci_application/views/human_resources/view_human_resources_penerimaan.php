<?php
    $activeModule = $this->session->userdata('setmodule');
?>
<script src="<?php echo base_url().ASSETS_JS; ?>functionset.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	$("#bankID").change(function(){
    		if ($(this).val()=="*"){
                $.post("json_support/loadBankCabangDefault", {

                }, function(e){
                    $("#cabangID").html("");
                    $(e).appendTo("#cabangID");
                    $('<option value=\'*\' selected> - </option>').appendTo("#cabangID");
                });

            }else{
                $.post("json_support/loadCabangByBank", {
                	bankID : $(this).val()
                }, function(e){
                    if (e.list=="kosong"){
                    	$('#myModal').modal('show');    
                    	$("#cabangID").html("");
                    	$('<option value=\'*\' selected>Pilih Cabang</option>').appendTo("#cabangID");
                    }else{
                    	
                    	$("#cabangID").html("");
                        $(e.list).appendTo("#cabangID");
                        $('<option value=\'*\' selected>Pilih Cabang</option>').appendTo("#cabangID");

                    }
                    
                },"json");

            }
    	});
       //$("#bankID").change(function(){
           // 
       // });
    });

    function simpanCabang(){
        $.post("references_bank/entryCabang",{
            modalBankID : $("#modalBankID").val()
            , cabangNama : $("#cabangNama").val()
            , modalAlamat : $("#modalAlamat").val()
            , modalPropinsiID : $("#modalPropinsiID").val()
            , modalKotaID : $("#modalKotaID").val()
            , modalKodePos : $("#modalKodePos").val()
            , modalNamaKontak : $("#modalNamaKontak").val()
            , modalTelepon : $("#modalTelepon").val()
            , modalFax : $("#modalFax").val()
            , modalEmail : $("#modalEmail").val()
            },function(e){
                    if (e == "True"){
                        $.post("json_support/loadCabangByBank", {
                            bankID : $("#bankID").val()
                    }, function(e){
                            $("#cabangID").html("");
                            $(e.list).appendTo("#cabangID");
                            $('<option value=\'*\' selected>Pilih Cabang</option>').appendTo("#cabangID");
                    },"json");
                    $('#myModal').modal('hide');
                }else{
                    $("#cabangID").html("");
                    $('<option value=\'*\' selected>Pilih Cabang</option>').appendTo("#cabangID");
                }
            });
    }
    
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
            	<ul class="nav nav-tabs">
					<li class='active'><a href="#0" data-toggle="tab">Informasi Diri</a></li>
					<li><a href="#1" data-toggle="tab">Informasi Kontak</a></li>
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
                <div class="modal hide" id="myModal">
							  <div class="modal-header">
							    <button type="button" class="close" data-dismiss="modal">×</button>
							    <h3>Success</h3>
							  </div>
							  <div class="modal-body">
							    <span class="span12">
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
	                                        <input type="text" class="input-square" id="cabangNama" name="cabangNama"/>
	                                    </div>
	                                </div>
	                                <div class="control-group">
	                                    <label class="control-label" for="basicround">Alamat</label>
	                                    <div class="controls">
	                                        <input type="text" class="input-square" id="modalAlamat" name="modalAlamat"/>
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
                                        <input type="text" name="modalKodePos" id="modalKodePos" class="input-square"/>
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
							  </div>
							  <div class="modal-footer">
                                                              <a href="#" onclick="simpanCabang();" class="btn btn-primary" >Simpan</a>
							    <a href="#" class="btn btn-primary" data-dismiss="modal">Batal</a>
							  </div>
							</div>
                <form id="myform" class="form-horizontal" method="post" action="<?php echo site_url($activeModule.'_karyawan/'.$mode); ?>">
                    <div class="tab-content">
                        
                        <div class="tab-pane active" id="0">
                            <span class="span6">
                                <div class="control-group">
                                    <label class="control-label" for="disabled">NO REGISTRASI</label>
                                    <div class="controls">
                                        <input type="text" class="input-square" readonly=""  value="<?php echo $noregistrasikaryawan;?>" id="noregistrasikaryawan" name="noregistrasikaryawan"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="disabled">NIP</label>
                                    <div class="controls">
                                        <input type="text" class="input-square" readonly="" value="<?php echo $nip;?>" id="nip" name="nip"/>
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
                                    <label class="control-label" for="datepicker">Tanggal Lahir</label>
                                    <div class="controls">
                                            <input type="text" class="datepick" id="tanggalLahir" name="tanggalLahir">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label for="select" class="control-label">Tempat Lahir (Kota)</label>
                                    <div class="controls">
                                        <select name="tempatLahir" id="tempatLahir">
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
                                <div class="control-group">
                                    <label for="select" class="control-label">Agama</label>
                                    <div class="controls">
                                        <select name="agama" id="agama">
                                            <option value="islam" selected>Islam</option>
                                            <option value="protestan" >Protestan</option>
                                            <option value="katholik" >Katholik</option>
                                            <option value="hindu" >Hindu</option>
                                            <option value="budha" >Budha</option>
                                            <option value="kepercayaan lain" >Kepercayaan</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label for="select" class="control-label">Jenis Kelamin</label>
                                    <div class="controls">
                                        <select name="gender" id="gender">
                                            <option value="L" selected>Laki-Laki</option>
                                            <option value="P" >Perempuan</option>
                                        </select>
                                    </div>
                                </div>
                            </span>
                        </div>
						
                        <div class="tab-pane" id="1">
                            <span class="span6">
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Alamat</label>
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
                                        <input type="text" name="kodePos" id="kodePos" class="span2 input-square"/>
                                    </div>
                                </div>
                            </span>
                            <span class="span6">
                                <div class="control-group">
                                    <label class="control-label" for="basicround">No Telepon</label>
                                    <div class="controls">
                                        <input type="text" name="nomortelepon" id="nomortelepon" class="input-square"/>
                                    </div>
                                </div>
                                <div class="control-group error">
                                    <label class="control-label" for="email1">Email</label>
                                    <div class="controls">
                                            <input type="text" class="email required ui-wizard-content ui-helper-reset ui-state-default" id="email" name="email"/><label for="email1" generated="true" class="error">Please enter a valid email address.</label>
                                    </div>
                                </div>
                                <div class="control-group"><hr/></div>
                                <div class="control-group">
                                    <label for="select" class="control-label">Bank</label>
                                    <div class="controls">
                                        <select name="bankID" id="bankID">
                                            <option value="*" selected>Pilih Bank</option>
                                            <?php foreach ($listBank as $r): ?>
                                                <option value="<?php echo $r["bankID"]; ?>"><?php echo $r["bankName"]; ?>( <?php echo $r["bankFullName"]; ?> )</option>
                                            <?php endforeach;?>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label for="select" class="control-label">Bank Cabang</label>
                                    <div class="controls" id="bankCabangBaru">
                                        <select name="cabangID" id="cabangID">
                                            <option value="*" selected>Pilih Cabang</option>
                                            <?php foreach ($loadBankCabang as $r): ?>
                                                <option value="<?php echo $r["cabangID"]; ?>"><?php echo $r["cabangNama"]; ?> - <?php echo $r["alamat"]; ?></option>
                                            <?php endforeach;?>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="control-group">
                                    <label class="control-label" for="basicround">Nama Account</label>
                                    <div class="controls">
                                        <input type="text" name="accRekening" id="accRekening" class="input-square"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="basicround">No Rekening</label>
                                    <div class="controls">
                                        <input type="text" name="noRekening" id="noRekening" class="input-square"/>
                                    </div>
                                </div>
                            </span>
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
                <!-- ISI //-->
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
                <!-- ISI //-->
            </div>
        </div>
    </div>
</div>