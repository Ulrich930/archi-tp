Voici un fichier `README.md` prêt à être utilisé dans ton dossier `archi-tp/`. Il documente la structure du projet, les objectifs par question, et les instructions de simulation.

---

```markdown
# TP Architecture des Ordinateurs – Groupe 2

## Objectif
Ce projet regroupe les réponses aux questions 2, 5 et 8 du TP d’Architecture des Ordinateurs.  
Chaque module Verilog a été conçu, testé sur EDA Playground, puis structuré ici avec son testbench associé.  

---

## Structure du projet

```

archi-tp/
├── question2\_multiplieur/
│   ├── multiplier.v         # Module Verilog du multiplieur binaire
│   ├── tb\_multiplier.v      # Testbench pour le multiplieur
├── question5\_multiplexeur/
│   ├── mux4to1.v            # Module Verilog du multiplexeur 4:1
│   ├── tb\_mux4to1.v         # Testbench pour le multiplexeur
├── question8\_bin2bcd/
│   ├── bin2bcd.v            # Module Verilog convertisseur binaire -> décimal
│   ├── tb\_bin2bcd.v         # Testbench complet
├── rapport\_tp.docx / .pdf   # Rapport détaillé à remettre
├── README.md                # Ce fichier

````

---

## Instructions générales

### Simulation locale avec Icarus Verilog (si installé)

```bash
# Exemple pour question 2
cd question2_multiplieur
iverilog -g2012 -o sim multiplier.v tb_multiplier.v
vvp sim
````

### Visualisation de waveform

```bash
# Ajouter dans le testbench :
$dumpfile("wave.vcd");
$dumpvars(0, <module_de_test>);

# Puis afficher avec GTKWave
gtkwave wave.vcd
```

---

## Détail des questions

### ✅ Question 2 : Multiplieur Binaire

* **Concepts abordés :** produit partiel, addition séquentielle, propagation de retenue.
* **Fichier :** `multiplier.v`
* **Testbench :** `tb_multiplier.v`

### ✅ Question 5 : Multiplexeur 4:1

* **Concepts abordés :** sélection de données par lignes de contrôle.
* **Fichier :** `mux4to1.v`
* **Testbench :** `tb_mux4to1.v`

### ✅ Question 8 : Convertisseur Binaire → Décimal

* **Concepts abordés :** algorithme Double Dabble, encodage BCD.
* **Fichier :** `bin2bcd.v`
* **Testbench :** `tb_bin2bcd.v`

---

## Auteur

Projet réalisé par **Nzau Lumendo Ulrich & Mukabi Ngombo Nelson & Lungi Selemani Josué & Mugaruka Tshioka Jeff**, Groupe 2
Encadrant : Ass. William M. Mutombo
Cours : Architecture des Ordinateurs, 1ICE

