// Below of code has been sourced from the lecturer Mikhail class teaching

function draw_table(){
    $("#results").empty();
    $.getHTMLuncached = function(url) {
        return $.ajax({
            url: url,
            type: 'GET',
            cache: false,
            success: function(html){
                $("#results").append(html);
            }
        });
    };
    $.getHTMLuncached("/get/html");
};

$(document).ready(function(){
    draw_table();
})