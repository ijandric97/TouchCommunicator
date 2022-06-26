
const doStuff = () => {
    var xhr = new XMLHttpRequest;
    xhr.open("GET", "mydir/myfile.txt");
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            var response = xhr.responseText;
            console.log(response);
            // use file contents as required
        }
    };
    xhr.send();

    console.log("PIKACHU");
}

// NOTE: DELETE ME
const exampleDBString = `
    {
        "":
    }
`

const exampleDB = {
    name: "root",
    image: "",
    audio: "",
    children: [
        {
            name: "sports",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp1",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp2",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp3",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp4",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp5",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp6",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp7",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp8",
            image: "",
            audio: "",
            children: [
            ]
        },
        {
            name: "temp9",
            image: "",
            audio: "",
            children: [
            ]
        }
    ]
}