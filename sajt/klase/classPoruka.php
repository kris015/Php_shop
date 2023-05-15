<?php
class Poruka{
    public static function greska($str){
        return "<div class='alert alert-danger'>{$str}</div>";
    }
    public static function uspeh($str){
        return "<div class='alert alert-success'>{$str}</div>";
    }
    public static function info($str){
        return "<div class='alert alert-info'>{$str}</div>";
    }
}
?>