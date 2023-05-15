$(function(){
    //alert("Uspeh");
})
function prikaziFormu(){
    let potvrda=document.querySelector("#cbKomentar");
    let forma=document.querySelector("#frmKomentari");
    //let dugme=document.querySelector("#dugme");
    if(potvrda.checked){
        forma.style.display="";
    } 
    else forma.style.display="none";
}

function dodajProizvod(idProizvoda){
    $.post("ajax/ajax_korpa.php?akcija=dodajProizvod", {idProizvoda: idProizvoda}, function(response){
        let odg=JSON.parse(response);
        //console.log(odg);
        if(odg.greska!="")alert(odg.greska);
        else alert(odg.uspeh);
    })
}