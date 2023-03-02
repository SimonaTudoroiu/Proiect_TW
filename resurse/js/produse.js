window.onload=function(){
    document.getElementById("inp-pret").onchange=function(){
        document.getElementById("infoRange").innerHTML=" ("+ this.value+ ")";
    }
    
    
    
    
    document.getElementById("filtrare").onclick=function(){
        var valNume=document.getElementById("inp-nume").value.toLowerCase();

        var butoaneRadio=document.getElementsByName("gr_rad");
        for(let rad of butoaneRadio){
            if(rad.checked){
                var valCantitate=rad.value;
                break;
            }
        }
        var minCantitate,maxCantitate;
        if(valCantitate!="toate"){
            [minCantitate,maxCantitate]=valCantitate.split(":");
            minCantitate=parseInt(minCantitate);
            maxCantitate=parseInt(maxCantitate);
        }
        else{
            minCantitate=0;
            maxCantitate=10000000;
        }

        var valPret=document.getElementById("inp-pret").value;

        var valCategorie=document.getElementById("inp-categorie").value;

        var optiuniCulori=document.getElementById("inp-culori").options;
        var valCulori=[];
        for(let opt of optiuniCulori){
            if(opt.selected)
                valCulori.push(opt.value);
            
        }

        var optiuniCuloriAvansate = document.getElementsByName("gr_chck");
        var valCuloriAvansateOricare=false;
        var valCuloriAre = [];
        var valCuloriNuAre = [];
        for(let i =0;i<optiuniCuloriAvansate.length;i++){
            if(optiuniCuloriAvansate[i].checked){
                if(optiuniCuloriAvansate[i].value == "oricare")
                {
                    valCuloriAvansateOricare = true;
                    break;
                }
                else{
                    var are=document.getElementById("i_rad"+i+"_are");
                    var nu_are=document.getElementById("i_rad"+i+"_nu_are");
                    if(are.checked){
                        valCuloriAre.push(optiuniCuloriAvansate[i].value);
                    }
                    else if(nu_are.checked){
                        valCuloriNuAre.push(optiuniCuloriAvansate[i].value);
                    }
                }
            }
        }

        var valSubcategorie = document.getElementById("i_datalist").value;

        var valTipCulori=document.getElementById("i_textarea").value.toLowerCase();

        var articole=document.getElementsByClassName("produs");
        for(let art of articole){
            art.style.display="none";
            let numeArt=art.getElementsByClassName("val-nume")[0].innerHTML.toLowerCase();

            let cond1=numeArt.startsWith(valNume);

            let cantitateArt=parseInt(art.getElementsByClassName("val-cantitate")[0].innerHTML);
            let cond2=(minCantitate <= cantitateArt) && (cantitateArt < maxCantitate);

            let pretArt=parseInt(art.getElementsByClassName("val-pret")[0].innerHTML);
            let cond3=(valPret <= pretArt);

            let categorieArt=art.getElementsByClassName("val-categorie")[0].innerHTML;
            let cond4=(valCategorie=="toate") || (categorieArt==valCategorie);


            let culoriArt1=art.getElementsByClassName("val-culori");
            
            
            culoriArt = [];
            for(let culoare of culoriArt1)
            {             
                var c = culoare.innerHTML;   
                culoriArt.push(c.substring(1,c.length-1).trim());
            }            
            

            let cond5 = true;
            for(let culoare of valCulori)
            {
                if(culoare == "oricare")
                    break;
                else{
                    let ok=false;
                    for(let c of culoriArt)
                    {
                        if(culoare == c)
                        {
                            ok = true;
                        }
                    }
                    cond5 = cond5 && ok;
                }
            }

            let cond6 = true;
            if(!valCuloriAvansateOricare){
                var ok1 = true;
                for(let culoare of valCuloriAre)
                {
                    let ok = false;
                    for(let c of culoriArt){
                        if(culoare == c)
                        {
                            ok = true;
                        }
                    }
                    ok1 = ok1 && ok;
                }
                var ok2 = true;
                for(let culoare of valCuloriNuAre){
                    let ok = true;
                    for(let c of culoriArt){
                        if(culoare == c)
                        {
                            ok = false;
                        }
                    }
                    ok2 = ok2&& ok;
                }
                cond6 = ok1 && ok2;
            }

            let subcategorieArt=art.getElementsByClassName("val-tip_produs")[0].innerHTML;
            var cond7 = (valSubcategorie == "oricare") || (valSubcategorie == subcategorieArt) || (valSubcategorie == "");

            let tipCuloriArt=art.getElementsByClassName("val-tip_culori")[0].innerHTML.toLowerCase();

            var cond8 = tipCuloriArt.startsWith(valTipCulori);
            
            let conditieFinala=cond1 && cond2 && cond3 && cond4 && cond5 && cond6 && cond7 && cond8;
            
            if(conditieFinala)
                art.style.display="grid";

        }
    }
    document.getElementById("resetare").onclick=function(){
        var articole=document.getElementsByClassName("produs");
        for(let art of articole){
            art.style.display="grid";
        }
        document.getElementById("inp-nume").value="";
        document.getElementById("i_rad4").checked=true;
        document.getElementById("sel-toate").selected=true;
        document.getElementById("inp-pret").value=0;
        document.getElementById("infoRange").innerHTML="(0)";
        document.getElementById("sel-mult-oricare").selected=true;
        var optiuniCuloriAvansate = document.getElementsByName("gr_chck");
        for(let i =0;i<optiuniCuloriAvansate.length;i++){
            if(optiuniCuloriAvansate[i].checked){
                if(optiuniCuloriAvansate[i].value == "oricare")
                {
                    break;
                }
                else{
                    var are=document.getElementById("i_rad"+i+"_are");
                    var nu_are=document.getElementById("i_rad"+i+"_nu_are");
                    
                    if(nu_are.checked){
                        nu_are.checked=false;
                        are.checked = true;
                    }
                    optiuniCuloriAvansate[i].checked=false;
                }
            }
        }
        document.getElementById("i_check_oricare").checked=true;
        document.getElementById("i_datalist").value="";
        document.getElementById("i_textarea").value="";
    }
    
    function sorteaza(semn){
        var articole=document.getElementsByClassName("produs");
        var v_articole= Array.from(articole);
        v_articole.sort(function(a,b){
            let cantitate_a=parseInt(a.getElementsByClassName("val-cantitate")[0].innerHTML);
            let cantitate_b=parseInt(b.getElementsByClassName("val-cantitate")[0].innerHTML);

            let pret_a=parseInt(a.getElementsByClassName("val-pret")[0].innerHTML); 
            let pret_b=parseInt(b.getElementsByClassName("val-pret")[0].innerHTML);
             
            let raport_a = cantitate_a/pret_a;
            let raport_b = cantitate_b/pret_b;

            if(raport_a!=raport_b)
                return semn*(raport_a - raport_b);
            else{
                //return dupa nume
                let subcategorie_a=a.getElementsByClassName("val-tip_produs")[0].innerHTML; 
                let subcategorie_b=b.getElementsByClassName("val-tip_produs")[0].innerHTML;
                let comp= subcategorie_a.localeCompare(subcategorie_b);
                return semn*comp;
            }
        })
        for(let art of v_articole){
            art.parentElement.appendChild(art);
        }
    }
    document.getElementById("sortCrescNume").onclick=function(){
        sorteaza(1);
    }
    document.getElementById("sortDescrescNume").onclick=function(){
        sorteaza(-1);
    }
    window.onkeydown=function(e){
        console.log(e);
        if(e.key=='c' && e.altKey){
            if(! document.getElementById("psuma"))
            {
                let suma1=0;
                let suma2=0;
                var articole=document.getElementsByClassName("produs");
                var ok = false;
                for(let art of articole){
                    if(art.style.display!="none"){
                        if(art.getElementsByClassName("select-cos")[0].checked){
                            ok = true;
                            suma1 += parseInt(art.getElementsByClassName("val-pret")[0].innerHTML);
                        }
                        else{
                            suma2 += parseInt(art.getElementsByClassName("val-pret")[0].innerHTML)
                        }
                    }
                }
                console.log(suma1);
                console.log(suma2);
                var pSuma=document.createElement("p");
                pSuma.id="psuma";
                if(!ok)
                    pSuma.innerHTML="<b> Suma: </b>"+suma2;
                else
                    pSuma.innerHTML="<b> Suma: </b>"+suma1;
                var sectiune=document.getElementById("produse");
                sectiune.parentElement.insertBefore(pSuma, sectiune);
                setTimeout(function(){
                    let p=document.getElementById("psuma");
                    if(p){
                        p.remove();
                    }
                }, 2000);
            }
        }
    }
}