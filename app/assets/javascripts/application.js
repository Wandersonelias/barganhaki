// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require bootbox.js
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks


//Sobrescreve data confirm
$.rails.allowAction = function(element) {
    var message = element.attr('data-confirm');
    if (!message) { return true; }
  
    var opts = {
      title: "Confirmação",
      message: message,
      buttons: {
          confirm: {
              label: 'Sim',
              className: 'btn-success'
          },
          cancel: {
              label: 'Não',
              className: 'btn-danger'
          }
      },
      callback: function(result) {
        if (result) {
          element.removeAttr('data-confirm');
          element.trigger('click.rails')
        }
      }
    };
  
    bootbox.confirm(opts);
  
    return false;
  }



var pagamento = {};
pagamento.cartao = function(){
  Iugu.setAccountID("7BF84F636188451EA2CE81F1FCA69DE5");
  Iugu.setTestMode(true); 
  Iugu.setup();

  var nome = $("#nomeCartao").val();
  var number = $("#numeroCartao").val();
  var month = $("#mesCartao").val();
  var year = $("#anoCartao").val();
  var cvv = $("#cvvCartao").val();

  var sobrenome = "";
  try{
    var splitName = nome.split(' ');
    nome = splitName[0];
    sobrenome = splitName[splitName.length-1];
  }catch(e){}

  cc = Iugu.CreditCard(number, month, year, nome, sobrenome, cvv);

  Iugu.createPaymentToken(cc, function(dados) {
    debugger
    if (dados.errors) {
      alert('Cartão inválido, tente novamente');
    } else {
      var data = {}
      data.token_id = dados.id
      data.months = 1 //$("#vezesCartao").val();
     

      var url = '/finalizar/compra.json';

      $.ajax({
        type: 'POST',
        url: url,
        headers: {
          'Accept': 'application/json; charset=utf-8',
          'Content-Type': 'application/json; charset=utf-8'
        },
        data: JSON.stringify(data)
      }).done(function() { 
        alert("Sucesso")
      }).fail(function(jqXHR, textStatus) {
        alert("erro")
      });
    }
  });

}