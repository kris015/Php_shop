<!--DESNI MENI-->
<div class="col-3">
    <?php
    if(login()){
        if($_SESSION['status']=="Administrator"){
            echo "<div class='okvir'>
                    <div class='naslovDesni'>ADMINISTRATOR</div>
                    <div>
                    <ul>
                        <li><a href='korisnici.php'>Rad sa korisnicima</a></li>
                        <!--<li><a href='dodajKorisnika.php'>Dodaj korisnika</a></li>
                        <li><a href='listakorisnika.php'>Izmeni/Obriši korisnika</a></li>-->
                        <li><a href='statistika.php'>Statistika</a></li>
                        <li><a href='komentari.php'>Komentari</a></li>
                        <li><a href='odgovori.php'>Postavljena pitanja</a></li>
                    </ul>
                    </div>
                </div>";
        }
    
        if($_SESSION['status']=="Administrator" or $_SESSION['status']=="Urednik"){
            echo "<div class='okvir'>
                    <div class='naslovDesni'>UREDNIK</div>
                    <div>
                    <ul>
                        <li><a href='dodajProizvod.php'>Dodaj proizvod</a></li>
                        <li><a href='listaProizvoda.php'>Izmeni/Obriši proizvod</a></li>
                    </ul>
                    </div>
                </div>";
        }
        echo "<div class='okvir'>
                    <div class='naslovDesni'>KORISNIK</div>
                    <div>
                    <ul>
                        <li><a href='korpa.php'>Korpa (<span id='spanKorpa'>0</span>)</a></li>
                        <li><a href='profil.php'>Profil</a></li>
                        <li><a href='pitanja.php'>Pitanja</a></li>
                        <li><a href='odjava.php'>Odjavite se</a></li>
                    </ul>
                    </div>
                </div><hr>";
    }
    

    ?>
    <div class="okvir">
        <div class="naslovDesni">Vremenska prognoza</div>
        <div>Danas je super!!!!</div>
    </div>

    <div class="okvir">
        <div class="naslovDesni">Kvalitet vazduha</div>
        <div>Vazduh je super!!!</div>
    </div>

    <div class="okvir">
        <div class="naslovDesni">Posetite nas</div>
        <div><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2828.6758073065553!2d20.402537315152955!3d44.8485351790985!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x475a65b17b627421%3A0x6d6130bffc362462!2sITAcademy!5e0!3m2!1ssr!2srs!4v1674156519244!5m2!1ssr!2srs" width="280" height="200" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe></div>
    </div>
</div>
<script>
    $(function(){
        $.post("ajax/ajax_korpa.php?akcija=prebrojProizvode", function(response){
            let odg=JSON.parse(response);
            $("#spanKorpa").html(odg.uspeh);
        })
    })
</script>