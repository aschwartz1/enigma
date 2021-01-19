# Enigma -- Final Project For Module 1
[Project Page](https://backend.turing.io/module1/projects/enigma/)

# Self Assessment
I think the project certainly at the 3 level. There are a couple of things I'm uncertain about, however.

I'm not sure the best class/module structure for this. Enigma is the only class we are required to have, but a full enigma with encrypt, decrypt, and cracking functionality would be pretty long. I saw that and used modules as organization and moved Encrypt and Decrypt to their own modules. I'm not sure if this is the best, and my modules depend on a set of methods to be implemented in Enigma. I don't feel great about the assumptions my solution is making.

Another problem with the modules relying on Enigma to implement a few methods is that SimpleCov gives a false negative on several methods and lowers the coverage percentage it calculates. Before the module refactor, I was at 100%. After, I'm at 95%. I am sure that this is because SimpleCov doesn't see, at the Enigma level, that the modules are calling methods it marks as uncovered.

Overall I think this project is passing and might demonstrate that I want organized, clean, good-OOP code but still am just in Mod 1 and can only do what I can.
