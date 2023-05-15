<?php
class Log{
    public static function upisi($imeDatoteke, $tekstZaUpis){
        $stariTekst="";
        if(file_exists($imeDatoteke))$stariTekst=file_get_contents($imeDatoteke);
        $noviTekst=date("d.m.Y H:i:s")." - {$tekstZaUpis}\n";
        file_put_contents($imeDatoteke, $noviTekst.$stariTekst);
    }
}
?>