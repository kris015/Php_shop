<?php
require_once("_obavezni.php");
//$db=konekcija();
$db=new Baza();
if(!$db->connect()) exit();
if(isset($_GET['email']) and isset($_GET['broj'])){
    $email=$_GET['email'];
    $vreme=$_GET['broj'];
    $upit="UPDATE korisnici SET registrovan=0 WHERE email='{$email}' and registrovan={$vreme}";
    $db->query($upit);
    if($db->affected_rows()==1)echo "Uspešna potvrda mejla<br>";
    else echo $upit."<br>Neupešna potvrda mejla<br>";
}
else
    echo "Svi podaci su obavezni!!!";
?>