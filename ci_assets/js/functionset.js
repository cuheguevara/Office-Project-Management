$(document).ready(function(){
    jQuery.fn.ForceNumericOnly =
    function()
    {
        return this.each(function()
        {
            $(this).keydown(function(e)
            {
                var key = e.charCode || e.keyCode || 0;
                // allow backspace, tab, delete, arrows, numbers and keypad numbers ONLY
                return (
                    key == 8 ||
                    key == 9 ||
                    key == 46 ||
                    (key >= 37 && key <= 40) ||
                    (key >= 48 && key <= 57) ||
                    (key >= 96 && key <= 105));
            });
        });
    };
	
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
