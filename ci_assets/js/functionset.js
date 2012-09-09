$(document).ready(function(){
    
	$("#modalPropinsiID").change(function(){
        if ($(this).val()=="*"){
            $.post("references_instansi/loadDefaultKota", {

            }, function(e){
                $("#modalKotaID").html("");
                $(e).appendTo("#modalKotaID");
                $('<option value=\'*\' selected>Pilih Kota</option>').appendTo("#modalKotaID");
            });

        }else{
            $.getJSON("references_instansi/loadByPropinsi", {
                propinsiID : $(this).val()
            }, function(e){
                $("#modalKotaID").html("");
                $(e.listKota).appendTo("#modalKotaID");
            }, 'json');

        }
    });
	
    $("#propinsiID").change(function(){
        if ($(this).val()=="*"){
            $.post("references_instansi/loadDefaultKota", {

            }, function(e){
                $("#kotaID").html("");
                $(e).appendTo("#kotaID");
                $('<option value=\'*\' selected>Pilih Kota</option>').appendTo("#kotaID");
            });

        }else{
            $.getJSON("references_instansi/loadByPropinsi", {
                propinsiID : $(this).val()
            }, function(e){
                $("#kotaID").html("");
                $(e.listKota).appendTo("#kotaID");
            }, 'json');

        }
    });
});
