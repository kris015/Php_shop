<?php
session_start();
require_once("_obavezni.php");
//Provera da li je korisnik ulogovan
if(!login()){
    echo "<h1>Morate biti prijavljeni!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    exit();
}
//Provera da li je korisnik ulogovan kao Administrator
if($_SESSION['status']!="Administrator"){
    echo "<h1>Morate biti prijavljeni kao Administrator!!!</h1><br><a href='prijava.php'>Prijavite se</a></div>";
    exit();
}

//$db=konekcija();
$db=new Baza();
if(!$db->connect()) exit();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>
    <div class="container">
        <!--HEADER-->
        <?php require_once("_header.php");?>
        <!--GORNJI MENI-->
        <?php require_once("_gornjimeni.php");?>
        
        <div class="row">
            <!--GLAVNI SADRŽAJ-->
            <div class="col-9">
                <h1>Rad sa korisnicima</h1>
                <hr>
                <input type="text" id="id" disabled><br><br>
                <input type="text" id="ime" placeholder="Unesite ime"><br><br>
                <input type="text" id="prezime"  placeholder="Unesite prezime"><br><br>
                <input type="text" id="email"  placeholder="Unesite email"><br><br>
                <select name="status" id="status">
                    <option value="">--Izaberite status--</option>
                    <option value="Administrator">Administrator</option>
                    <option value="Urednik">Urednik</option>
                    <option value="Korisnik">Korisnik</option>
                </select><br><br>
                <input type="checkbox" id="aktivan" value="0" > Aktivan? <br><br>
                <input type="checkbox" id="obrisan" value="0" > Obrisan? <br><br>
                <button class="btn btn-primary btn-sm" id="btnSnimi" onclick="snimiKorisnika()">Snimi korisnika</button> 
                <button class="btn btn-danger btn-sm" id="btnObrisi">Obriši korisnika</button> 
                <button class="btn btn-secondary btn-sm" id="btnOcisti" onclick="ocistiSve()">Očisti polja</button> 
                <div id="divOdgovor"></div>
                <hr>
                <input type="text" id="termin" placeholder="Unesite termin pretrage" onkeyup="prikaziKorisnike()"> <button class="btn btn-success btn-sm" onclick="prikaziKorisnike()">Pretraži</button> <br>
                <div id="divKorisnici">
                    
                </div>
                <hr>
                
                
                
            </div>
            <!--DESNI MENI-->
            <?php require_once("_desnimeni.php");?>
        </div>

        <!--FUTER-->
        <?php require_once("_footer.php");?>

    </div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<script>
    $(function(){
        prikaziKorisnike();
        $("#btnObrisi").click(function(){
            let id=$("#id").val();
            if(id==""){
                alert("Morate izabrati korisnika za brisanje");
                return false;
            }
            if(!confirm("Da li ste sigurni da želite da izbrišete korisnika\n"+$("#ime").val()+" "+$("#prezime").val())) return false;
            $.post("ajax/ajax_korisnici.php?akcija=delete", {id: id}, function(response){
                $("#divOdgovor").html(response);
                ocistiSve();
                prikaziKorisnike();
            })
        })
       
    })

    function ocistiSve(){
        $("input").val("");
        $("select").val("");
        $("[type='checkbox']").removeAttr("checked");
    }

    function prikaziKorisnike(){
        $("#divKorisnici").html("Podaci se učitavaju...<br><img src='loading.gif' height='100px'>")
        /*$("#divKorisnici").load("ajax/ajax_korisnici.php?akcija=select", function(){
            dodajAkciju();
        });*/
        let termin=$("#termin").val();
        $.post("ajax/ajax_korisnici.php?akcija=select", {termin:termin}, function(response){
            $("#divKorisnici").html(response);
            dodajAkciju();
        })
    }

    function dodajAkciju(){
        $(".korisnik").click(function(){
            $("#id").val($(this).data("id"));
            $("#ime").val($(this).data("ime"));
            $("#prezime").val($(this).data("prezime"));
            $("#email").val($(this).data("email"));
            $("#status").val($(this).data("status"));
            if($(this).data("aktivan")=="1")$("#aktivan").attr("checked", "checked");
            else $("#aktivan").removeAttr("checked");
            if($(this).data("obrisan")=="1")$("#obrisan").attr("checked", "checked");
            else $("#obrisan").removeAttr("checked");
        })
    }

    function snimiKorisnika(){
        $("#divKorisnici").html("Podaci se učitavaju...<br><img src='loading.gif' height='100px'>")
        let id=$("#id").val();
        let ime=$("#ime").val();
        let prezime=$("#prezime").val();
        let email=$("#email").val();
        let status=$("#status").val();
        let aktivan=0;
        let obrisan=0;
        if($("#aktivan").is(":checked"))aktivan=1;
        if($("#obrisan").is(":checked"))obrisan=1;
        //console.log(aktivan);
        //console.log(obrisan);
        $.post("ajax/ajax_korisnici.php?akcija=snimiKorisnika", {id:id, ime:ime, prezime:prezime, email:email, status:status, aktivan:aktivan, obrisan:obrisan}, function(response){
            $("#divOdgovor").html(response);
            ocistiSve();
            prikaziKorisnike();
        })
    }
</script>