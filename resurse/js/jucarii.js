window.onload=function(){

    function sorteaza(semn){
        var articole=document.getElementsByClassName("jucarie");
        var v_articole= Array.from(articole);
        v_articole.sort(function(a,b){
            let varsta_a=parseInt(a.getElementsByClassName("val-varsta")[0].innerHTML);
            let varsta_b=parseInt(b.getElementsByClassName("val-varsta")[0].innerHTML);


            
            if(varsta_a!=varsta_b)
                return semn*(varsta_a - varsta_b);
            else{
                let pret_a=parseInt(a.getElementsByClassName("val-pret")[0].innerHTML); 
                let pret_b=parseInt(b.getElementsByClassName("val-pret")[0].innerHTML);
            
                return semn*(pret_a-pret_b);
            }
            
        })
        for(let art of v_articole){
            art.parentElement.appendChild(art);
        }
    }
    
    document.getElementById("sortare").onclick=function(){
        var butoaneRadio=document.getElementsByName("gr_rad");
        for(let rad of butoaneRadio){
            if(rad.checked){
                var valSortare=rad.value;
                break;
            }
        }
        if(valSortare=="ascendent"){
            sorteaza(1);
        }
        else if(valSortare=="descendent"){
            sorteaza(-1);
        }
    }
    document.getElementById("filtrare").onclick=function(){
        var optiuniCulori = document.getElementById("i_sel_simplu").options;
        var valCuloare;
        for(let opt of optiuniCulori){
            if(opt.selected){
                valCuloare = opt.value;
                break;
            } 
        }
        var articole=document.getElementsByClassName("jucarie");
        for(let art of articole){
            art.style.display="none";
            let culoriArt1=art.getElementsByClassName("val-culori");
            
            
            culoriArt = [];
            for(let culoare of culoriArt1)
            {             
                var c = culoare.innerHTML;   
                culoriArt.push(c.substring(1,c.length).trim());
            }          
            let cond = false;
            if(valCuloare == "toate")
                cond = true;
            else{
            for(let c of culoriArt){
                if(valCuloare==c)
                    {
                        cond = true;
                        break;
                    }
            }}
            
            if(cond)
                art.style.display="grid";
        }
        setTimeout(function(){
            for(let art of articole)
                art.style.display = "grid";
                document.getElementById("sel-toate").selected=true;

        }, 5000)
    }
    var jucarii = document.getElementsByClassName("jucarie");
    var suma = 0;
    var pSuma=document.createElement("p");
    pSuma.id="psuma";
    for(let j of jucarii)
    {
        var ok = false;
        if(ok==false){
        j.onclick = function(){
            j.style.border = "solid 10px green";
            j.style.borderStyle= "dotted";
            let p=document.getElementById("psuma");
            if(p){
                p.remove();
            }
            suma += parseInt(j.getElementsByClassName("val-pret")[0].innerHTML);
            pSuma.innerHTML = "<b> Suma: </b>"+suma;
            var sectiune=document.getElementById("jucarii");
            sectiune.parentElement.insertBefore(pSuma, sectiune);
            ok=true;
        }
        }
        if(ok==true){
        j.onclick = function(){
            j.style.border = "none";
            j.style.borderStyle= "none";
            let p=document.getElementById("psuma");
            if(p){
                p.remove();
            }
            suma -= parseInt(j.getElementsByClassName("val-pret")[0].innerHTML);
            pSuma.innerHTML = "<b> Suma: </b>"+suma;
            var sectiune=document.getElementById("jucarii");
            sectiune.parentElement.insertBefore(pSuma, sectiune);
            
        }
    }
    }
}