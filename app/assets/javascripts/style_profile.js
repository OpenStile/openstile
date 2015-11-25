/**
 * Created by tamaraaustin on 9/4/15.
 */

function showFieldset(index){
    var fieldsets = $('.fieldset-' + index);
    if(fieldsets.length != 0){
        $('fieldset').hide();
        fieldsets.show();
    }
}

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

    $('.style-form fieldset').hide();
    $('.style-form input#wizard-save').hide();
    $('.style-form a#wizard-next').show();

    var current_fieldset = 1;
    var max_fieldsets = 5;

    showFieldset(current_fieldset);

    $('.style-form a#wizard-next').click(function(){
        current_fieldset++;
        $('.style-form a#wizard-back').show();
        if(current_fieldset == max_fieldsets){
            $('.style-form a#wizard-next').hide();
            $('.style-form input#wizard-save').show();
        }
        showFieldset(current_fieldset);
        $('body').scrollTop(0);
    });

    $('.style-form a#wizard-back').click(function(){
        current_fieldset--;
        $('.style-form a#wizard-next').show();
        $('.style-form input#wizard-save').hide();
        if(current_fieldset == 1){
            $('.style-form a#wizard-back').hide();
        }
        showFieldset(current_fieldset);
        $('body').scrollTop(0);
    });
});
