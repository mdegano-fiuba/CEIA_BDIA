## Objetivo

Este repositorio contiene los desafíos elaborados en el contexto de la materia "**Procesamiento del Lenguaje Natural**" de la carrera de "*Especialización en Inteligencia Artificial*" de la *Facultad de Ingeniería* de la *Universidad de Buenos Aires*.


* **Docente**:  
Dr. Rodrigo Cardenas Szigety
<br><a href="mailto:rodrigo.cardenas.sz@gmail.com"><img alt="Email" src="https://img.shields.io/badge/Gmail-rodrigo.cardenas.sz@gmail.com-B9E1F5?style=flat-square&logo=gmail"></a>


* **Alumno**:  
Ing. Myrna Degano (a1618)
<br><a href="mailto:myrna.l.degano@gmail.com"><img alt="Email" src="https://img.shields.io/badge/Gmail-myrna.l.degano@gmail.com-B9E1F5?style=flat-square&logo=gmail"></a>


* **Referencias**:  
<a href="https://github.com/FIUBA-Posgrado-Inteligencia-Artificial/procesamiento_lenguaje_natural" target="_blank"><img alt="GitHub" src="https://img.shields.io/badge/FIUBA%20Posgrado%20Inteligencia%20Artificial-Procesamiento%20lenguaje%20natural-B9E1F5?style=flat-square&logo=github"></a>


* **Recursos**:  
<img src="https://img.shields.io/badge/Python-B9E1F5?style=for-the-badge&logo=python&logoColor=white" alt="Python" /> <img src="https://img.shields.io/badge/Numpy-B9E1F5?style=for-the-badge&logo=numpy&logoColor=white" alt="Numpy" /> <img src="https://img.shields.io/badge/Pandas-B9E1F5?style=for-the-badge&logo=pandas&logoColor=white" alt="Pandas" /> <img src="https://img.shields.io/badge/Keras-B9E1F5?style=for-the-badge&logo=keras&logoColor=white" alt="Keras" /> <img src="https://img.shields.io/badge/TensorFlow-B9E1F5?style=for-the-badge&logo=tensorflow&logoColor=white" alt="TemsorFlow" /> <img src="https://img.shields.io/badge/Plotly-B9E1F5?style=for-the-badge&logo=plotly&logoColor=white" alt="Plotly" /> <img src="https://img.shields.io/badge/scikit_learn-B9E1F5?style=for-the-badge&logo=scikit-learn&logoColor=white" alt="Scikit-learn" />

<br><br>
## Desafío 1

* **Tema**:  
VECTORIZACION DE DOCUMENTOS

* **Objetivos**:  
   - Crear vectores con Gensim  
   - Probar términos de interés  
   - Medir similaridad  
   - Probar test de analogías  
   - Graficar embeddings  

* **Resumen**:  
Sobre un conjunto de datos dado (20 Newsgroups) utilizado comúnmente para tareas de clasificación de texto y que contiene publicaciones de 20 grupos de noticias diferentes se realizaron diferentes experimentos para comparar y obtener conclusiones.  Se evaluaron diferentes métodos de vectorización (TfidfVectorizer, CountVectorizer) y se evaluó similaridad entre ciertos documentos tomados al azar con el resto de los documentos del corpus.  Se entrenaron diferentes modelos de clasificación Naive Bayes buscando maximizar el desempeño de clasificación sobre el conjunto de datos (Multinomial, ComplementNB) y medir similaridad entre palabras.  <br>  
<a href="https://github.com/mdegano-fiuba/CEIA_NLP/tree/main/1.%20Vectorizaci%C3%B3n" target="_blank"><img alt="Notebook" src="https://img.shields.io/badge/Google%20Colab-Ver%20notebook%20(Desarrollo%20y%20conclusiones)-B9E1F5?style=flat-square&logo=googlecolab"></a>

<br><br>
## Desafío 2

* **Tema**:  
EMBEDDINGS

* **Objetivos**:  
   - Creación de embeddings de palabras 
   - Tokenización
   - Similitudes entre palabras
   - Pruebas de analogías
   - Visualización  

* **Resumen**:  
Se utilizó para el análisis un corpus armado con archivos *.txt con los cuentos más famosos de los hermanos Grimm.  Se realizó la tokenización por palabras para evaluar similaridad entre términos y hacer pruebas de analogías.  Se exploraron diferentes modelos de embeddings de palabras (Glove, Fasttext) y se realizaron diferentes entrenamientos modificando parámetros para analizar comparativamente su desempeño.  <br>  
<a href="https://github.com/mdegano-fiuba/CEIA_NLP/tree/main/2.%20Word Embeddings" target="_blank"><img alt="Notebook" src="https://img.shields.io/badge/Google%20Colab-Ver%20notebook%20(Desarrollo%20y%20conclusiones)-B9E1F5?style=flat-square&logo=googlecolab"></a>

<br><br>
## Desafío 3

* **Tema**:  
MODELOS DE LENGUAJE

* **Objetivos**:
   - Entrenar un modelo de lenguaje
   - Realizar el preprocesamiento adecuado para tokenizar el corpus
   - Proponer arquitecturas de redes neuronales basadas en unidades recurrentes para implementar el modelo
   - Generar secuencias nuevas a partir de secuencias de contexto
   - Probar estrategias de greedy search / beam search determinístico y estocástico
   - Probar el efecto de la temperatura en la generación de secuencias 

* **Resumen**:  
Sobre el cuento "El Gato Negro" de Edgar Allan Poe se realizó el entrenamiento de diferentes modelos de lenguaje.  Se exploraron arquitecturas LSTM, GRU y RNN.  Se evaluó la generación de nuevas secuencias a partir de secuencias de entrada aplicando las diferentes técnicas propuestas.  <br>  
<a href="https://github.com/mdegano-fiuba/CEIA_NLP/tree/main/3.%20Modelo%20de%20lenguaje" target="_blank"><img alt="Notebook" src="https://img.shields.io/badge/Google%20Colab-Ver%20notebook%20(Desarrollo%20y%20conclusiones)-B9E1F5?style=flat-square&logo=googlecolab"></a>

<br><br>
## Desafío 4

* **Tema**:  
BOT DE PREGUNTAS Y RESPUESTAS

* **Objetivos**:  
   - Construir un bot para responder a preguntas del usuario.

* **Resumen**:  
A partir del conjunto de datos propuesto se entrenaron varios modelos con arquitectura Encoder-Decoder con diferentes parámetros para evaluar el desempeño comparativo del bot generando respuestas a las preguntas ingresadas como input.  <br>  
<a href="https://github.com/mdegano-fiuba/CEIA_NLP/tree/main/4.%20Q&A%20Bot" target="_blank"><img alt="Notebook" src="https://img.shields.io/badge/Google%20Colab-Ver%20notebook%20(Desarrollo%20y%20conclusiones)-B9E1F5?style=flat-square&logo=googlecolab"></a>

<br><br>
## ...    
<div align="center">
   <a href="https://mdegano-fiuba.github.io/CEIA_NLP/" target="_blank"><img src="https://img.shields.io/badge/%F0%9F%8F%A0-Ver%20en%20GitHub%20Pages-B9E1F5?style=flat-square" alt="Home">
</a></div>
