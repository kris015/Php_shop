<?php
class Baza{
    private $db;
    public function connect(){
        mysqli_report(MYSQLI_REPORT_OFF);
        $this->db=@mysqli_connect("localhost", "root", "", "g1");
        if(!$this->db){
            echo "Greška prilikom konekcije na bazu!!!<br>";
            echo mysqli_connect_errno().": ".mysqli_connect_error()."<br>";
            return false;
        }
        $this->query("SET NAMES utf8");
        return $this->db;
    }

    public function query($upit){
        return mysqli_query($this->db, $upit);
    }
    public function fetch_assoc($rez){
        return mysqli_fetch_assoc($rez);
    }
    public function fetch_object($rez){
        return mysqli_fetch_object($rez);
    }
    public function fetch_all($rez){
        return mysqli_fetch_all($rez);
    }

    public function error(){
        if(mysqli_error($this->db))return mysqli_errno($this->db).": ".mysqli_error($this->db);
        else return false;
    }
    public function num_rows($rez){
        return mysqli_num_rows($rez);
    }
    public function affected_rows(){
        return mysqli_affected_rows($this->db);
    }
    public function insert_id(){
        return mysqli_insert_id($this->db);
    }

    public function __destruct(){
        if($this->db)mysqli_close($this->db);
    }

}
?>