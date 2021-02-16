from sandman2 import get_app

app = get_app('mysql://root:SenhaSuperSecreta2030@localhost/classicmodels')

if __name__ == '__main__':
    app.run(debug=True)
