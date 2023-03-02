const express= require("express");
const fs=require("fs");
const sharp=require("sharp");
const ejs=require("ejs");
const sass=require("sass");
const {Client}=require("pg");

var client=new Client({user:"tudoroiu_simona", password:"simona02", database:"proiect", host:"localhost", port: 5432});

// var client=new Client({user:"rxhqrxltkcvzju", 
//                     password:"ea7362269d895c789c727047e4bc877a81badebfa249c8c88be64981a450d93c", 
//                     database:"d687025coc9hm5", 
//                     host:"ec2-54-227-248-71.compute-1.amazonaws.com", 
//                     port: 5432,
//                     ssl: {
//                         rejectUnauthorized: false
//                       }});

client.connect();

// const obGlobal={obImagini:null,obErori:null};

app = express();

app.set("view engine","ejs");

app.use("/resurse", express.static(__dirname+"/resurse"))

app.get(["/","/index", "/home"], function(req, res){
    // res.sendFile(__dirname+"/index1.html");
    client.query("select * from tabel_test", function(err, rezQuery){
        // console.log(rezQuery)
        if(!err)
            res.render("pagini/index",{ip: req.ip, imagini: poze, imag_galerie: pozeGalAnim, titlu: obImagini.titlul, descriere: obImagini.descriere, produse: rezQuery.rows});

    })
})


app.get("/produse", function(req, res){
    // console.log(req.query);
    client.query("select * from unnest(enum_range(null::categ_zona))", function(err, rezCateg){
        var cond_where=req.query.tip ? ` categorie='${req.query.tip}'` : " 1=1";
        client.query("select * from machiaje where "+cond_where, function(err, rezQuery){
            console.log(err);
            // console.log(rezQuery);
            res.render("pagini/produse", {produse: rezQuery.rows , optiuni:rezCateg.rows});
        });
    });
    
});


app.get("/produs/:id", function(req, res){
    client.query(`select * from machiaje where id=${req.params.id}`, function(err, rezQuery){
        // console.log(rezQuery);
        res.render("pagini/produs",{prod: rezQuery.rows[0]});
    });
});

app.get("/jucarii", function(req, res){
    querySelect=`select * from jucarii`;

    client.query(querySelect, function(err, rezQuery){
        console.log(rezQuery)
        res.render("pagini/jucarii", {jucarii:rezQuery.rows});
    });

});

app.get("*/galerie-animata.css",function(req, res){
    
    var sirScss=fs.readFileSync(__dirname+"/resurse/scss/galerie_animata.scss").toString("utf8");
    var culori=["navy","black","purple","grey"];
    var indiceAleator=Math.floor(Math.random()*culori.length);
    var culoareAleatoare=culori[indiceAleator]; 
    rezScss=ejs.render(sirScss,{culoare:culoareAleatoare});
    // console.log(rezScss);
    var caleScss=__dirname+"/temp/galerie_animata.scss"
    fs.writeFileSync(caleScss,rezScss);
    try {
        rezCompilare=sass.compile(caleScss,{sourceMap:true});
        
        var caleCss=__dirname+"/temp/galerie_animata.css";
        fs.writeFileSync(caleCss,rezCompilare.css);
        res.setHeader("Content-Type","text/css");
        res.sendFile(caleCss);
    }
    catch (err){
        console.log(err);
        res.send("Eroare");
    }
});
app.get("*/galerie-animata.css.map",function(req, res){
    res.sendFile(path.join(__dirname,"temp/galerie-animata.css.map"));
});

app.get("/eroare", function(req, res){
    randeazaEroare(res,1, "Titlu schimbat");

});
app.get("/*.ejs", function(req,res){
    // res.status(403).render("pagini/403");
    randeazaEroare(res,403);
})
app.get("/despre", function(req,res){
    res.render("pagini/despre");
})
app.get("/ceva", function(req, res){
    res.write("Salut");
    res.end();
})

app.get("/*", function(req, res){
    res.render("pagini"+req.url, function(err, rezRender){
        if (err){
            if(err.message.includes("Failed to lookup view")){
                console.log(err);
                // res.status(404).render("pagini/404");
                randeazaEroare(res,404);
            }
            else{
                
                res.render("pagini/eroare_generala");
            }
        }
        else{
            // console.log(rezRender);
            res.send(rezRender);
        }
    });
    // console.log("generala:",req.url);
    res.end();
})

function creeazaErori(){
    var buf=fs.readFileSync(__dirname+"/resurse/json/erori.json").toString("utf8");
    obErori=JSON.parse(buf);//global
}
creeazaErori();

function randeazaEroare(res, identificator, titlu, text, imagine){
    var eroare= obErori.erori.find(function(elem){return elem.identificator == identificator});
    titlu= titlu || (eroare && eroare.titlu) || "Titlu eroare custom";
    text= text || (eroare && eroare.text) || "Titlu eroare custom";
    imagine= imagine || (eroare && (obErori.cale_baza+"/"+eroare.imagine)) || "Titlu eroare custom";
    if(eroare && eroare.status)
        res.status(eroare.identificator);
    res.render("pagini/eroare_generala",{titlu:titlu, text:text, imagine: imagine});

}
function creeazaImagini(){
    var buf=fs.readFileSync(__dirname+"/resurse/json/galerie.json").toString("utf8");


    obImagini=JSON.parse(buf);//global



    //console.log(obImagini);
    for (let imag of obImagini.imagini){
        let nume_imag, extensie;
        [nume_imag, extensie ]=imag.fisier.split(".")// "abc.de".split(".") ---> ["abc","de"] imagine.png->imagine.webp
        let dim_mic=150
        
        imag.mic=`${obImagini.cale_galerie}/mic/${nume_imag}-${dim_mic}.png` //nume-150.webp // "a10" b=10 "a"+b `a${b}`
        //console.log(imag.mic);


        imag.mare=`${obImagini.cale_galerie}/${imag.fisier}`;
        if (!fs.existsSync(imag.mic))
            sharp(__dirname+"/"+imag.mare).resize(dim_mic).toFile(__dirname+"/"+imag.mic);


        let dim_mediu=300;
        imag.mediu=`${obImagini.cale_galerie}/mediu/${nume_imag}-${dim_mediu}.png` 
        if (!fs.existsSync(imag.mediu))
            sharp(__dirname+"/"+imag.mare).resize(dim_mediu).toFile(__dirname+"/"+imag.mediu);

        let today = new Date();
        let minute = today.getMinutes();
        poze = [];
        let i = 0;
        for(let imag of obImagini.imagini){
            let sfert_ora = imag.sfert_ora;
            if(minute >= '00' && minute < "15"){
                if(sfert_ora == "1"){
                    poze.push(imag);
                    i++;
                }
            }
            else{
                if(minute >= "15" && minute < "30"){
                    if(sfert_ora == "2"){
                        poze.push(imag);
                        i++;
                    }
                }
                else{
                    if(minute >= "30" && minute < "45"){
                        if(sfert_ora == "3"){
                            poze.push(imag);
                            i++;
                        }
                    }
                    else{
                        if(minute >= "45" && minute <= "59"){
                            if(sfert_ora == "4"){
                                poze.push(imag);
                                i++;
                            }
                        }
                    }
                }
            }
            if(i == 10){
                break;
            }
        }            
    }
    // console.log(poze);
}
creeazaImagini();
function creeazaImaginiGalAnim(){
    
    pozeGalAnim = [];
    for(let imag of obImagini.imagini){
        let ga = imag.galerie_animata;
        if(ga == true){
            pozeGalAnim.push(imag);
        }
    }
}
creeazaImaginiGalAnim();

var s_port=process.env.PORT || 8080;
app.listen(s_port); 

// app.listen(8080);
console.log("A pornit")
