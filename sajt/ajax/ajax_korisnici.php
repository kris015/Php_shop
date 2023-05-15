<?php
    mysqli_report(MYSQLI_REPORT_OFF);
    $db=mysqli_connect("localhost", "root", "", "g1");
    mysqli_query($db, "SET NAMES UTF8");
    $akcija=$_GET['akcija'];


    if($akcija=="snimiKorisnika"){
        extract($_POST);
        if($id=="")$upit="INSERT INTO korisnici (id, ime, prezime, email,lozinka, status, aktivan, obrisan) VALUES (null, '{$ime}', '{$prezime}','{$email}','12345','{$status}',{$aktivan},{$obrisan})";
        else $upit="UPDATE korisnici SET ime='{$ime}', prezime='{$prezime}', status='{$status}', aktivan={$aktivan}, obrisan={$obrisan} WHERE id={$id}";
        mysqli_query($db, $upit);
        if(mysqli_error($db))echo mysqli_error($db);
        else echo "Broj izmenjenih/dodatih: ".mysqli_affected_rows($db);
    }
    if($akcija=="delete"){
        if(isset($_POST['id'])){
            $id=$_POST['id'];
            $upit="UPDATE korisnici set obrisan=1 WHERE id={$id}";
            mysqli_query($db, $upit);
            echo "Broj obrisanih: ".mysqli_affected_rows($db);
        }
    }

    /*if($akcija=="insert"){
        
    }*/
    if($akcija=="select"){
        $termin=$_POST['termin'];
        if($termin=="")$upit="SELECT * FROM korisnici WHERE obrisan=0";
        else $upit="SELECT * FROM korisnici WHERE ime LIKE('%{$termin}%') or prezime LIKE ('%{$termin}%') or email LIKE ('%{$termin}%') where obrisan=0";
        $rez=mysqli_query($db, $upit);
        while($red=mysqli_fetch_object($rez)){
            echo "<div class='korisnik' 
            data-id='{$red->id}' 
            data-ime='{$red->ime}' 
            data-prezime='{$red->prezime}' 
            data-email='{$red->email}' 
            data-status='{$red->status}' 
            data-aktivan='{$red->aktivan}' 
            data-obrisan='{$red->obrisan}'
            >{$red->id}: {$red->ime} {$red->prezime}</div>";
        }
    }




    
?>