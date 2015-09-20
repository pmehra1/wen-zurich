 $(document).ready(function () {
        $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });

        $('#familyDetailsPlus').click(function () {
            var count = $("#familyDetails >tbody > tr").size()
            var str = 'familyDetailsRowId' + count;
            var datepicker = 'datepicker' + count;
            var row1 = $("<tr id='familyDetailsRowId" + count + "' width=100%>"
            + "<td align='center'><input type='text' id='membername-" + count + "' name='membername-" + count + "' style='width: 150px;'/></td>"
            + "<td align='center'><input type='text' id='memberoccupation-" + count + "' name='memberoccupation-" + count + "' style='width: 150px;'/></td>"
            + "<td align='center'><input type='text' id='memberrel-" + count + "' name='memberrel-" + count + "' style='width: 150px;'/></td>"
            + "<td align='center'><input type='text' id='memberyrssupport-" + count + "' name='memberyrssupport-" + count + "' style='width: 150px;'/></td>"
            + "<td align='center'><input type='text' id=" + datepicker + " name=" + datepicker + " style='width: 150px;'/>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='../../Content/delete-icon.png' /></a></td>"
            + "</tr>");
            $("#familyDetails").append(row1);
            
            $('[name="datepicker"]').datepicker();
        });

    });

    $(function () {
        $.datepicker.setDefaults($.datepicker.regional['']);

    });

    function DeleteRow(param) {
        var answer = confirm("Delete Family member?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
        }
        else {

        }
        

    }