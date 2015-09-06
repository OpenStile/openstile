/**
 * Created by tamaraaustin on 9/4/15.
 */

$(document).ready(function(){
    $('.style-form .fieldset .toggle').click(function(){
        $(this).toggleClass('fa-caret-down')
        $(this).toggleClass('fa-caret-right');
        if ($(this).is('.fa-caret-down')) {
            $(this).closest('.fieldset').find('.content').show();
        } else {
            $(this).closest('.fieldset').find('.content').hide();
        }
    });

    $('.style-form .img-selector').click(function() {
        $(this).toggleClass('checked');

        input_el = $('#'+$(this).data('id'));
        input_el.prop('checked', !input_el.prop('checked'));
    });
});