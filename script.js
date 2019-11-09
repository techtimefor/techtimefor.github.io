know = {
                "hello" : "Bot: hi",
                "yo" : "Bot: Whats up!",
                "how are you?" : "Bot: good",
                "hmm" : "hmmmmmm",
                "who made hmmbot" : "Bot: techtimefor",
                "ok" : "Bot: :)",
                 "how do i invite hmmbot" : "Bot: Sorry you can't for now",
            };
            function talk() {
                var user = document.getElementById("userBox").value;
                document.getElementById("userBox").value = "";
                document.getElementById("chatLog").innerHTML += user+"<br>";
                if (user in know) {
                    document.getElementById("chatLog").innerHTML += know[user]+"<br>";
                } else {
                    document.getElementById("chatLog").innerHTML += "Bot: Sorry i dont know<br>";
                }
            }
            
