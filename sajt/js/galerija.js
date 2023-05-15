//definica slika u nizu
//let slike=["slike/slika1.jpg", "slike/slika2.jpg", "slike/slika3.jpg", "slike/slika4.jpg", "slike/slika5.jpg", "slike/slika6.jpg"];

//Morate imati div sa id="galerija" u okviru stranice
//Morate priključiti ovaj script na kraju stranice

//referenca na držač galerije
//if(slike.length==0) return false;
let galerija=document.querySelector("#galerija");
galerija.style.cssText="width:500px; height:400px; background-color:lightgray;text-align: center";
let glavna=document.createElement("img");
glavna.height="250";
glavna.src=slike[0];
glavna.setAttribute("data-rbr", 0);
galerija.appendChild(glavna);
galerija.appendChild(document.createElement("br"));

for(i=0;i<slike.length;i++){
    let slicica=document.createElement("img");
    slicica.height="50";
    slicica.src=slike[i];
    slicica.setAttribute("data-rbr", i);
    slicica.style.cssText="cursor: pointer; margin:2px";
    slicica.onclick=function(){
        glavna.src=this.src;
        glavna.setAttribute("data-rbr", this.getAttribute("data-rbr"));
    }
    slicica.onmouseenter=function(){
        this.style.border="2px solid red";
        this.height+=5;
    }
    slicica.onmouseleave=function(){
        this.style.border="0px solid red";
        this.height-=5;
    }
    galerija.appendChild(slicica);
}
let timer;
if(slike.length>0) timer=setInterval(promeniSliku, 2000);

function promeniSliku(){
    clearInterval(timer);
    tekuca=glavna.getAttribute("data-rbr");
    sledeca=parseInt(tekuca)+1;
    if(sledeca==slike.length)sledeca=0;
    glavna.src=slike[sledeca];
    glavna.setAttribute("data-rbr", sledeca);
    timer=setInterval(promeniSliku, 2000);
}
