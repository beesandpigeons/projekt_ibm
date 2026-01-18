from flask import Flask, request, jsonify
import sqlite3
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

DB_PATH = 'dane.db'

def query_db(query, args=()):
    con = sqlite3.connect(DB_PATH)
    con.row_factory = sqlite3.Row
    cur = con.execute(query, args)
    rows = cur.fetchall()
    con.close()
    return [dict(row) for row in rows]

@app.route('/search')
def search():
    q = request.args.get('q', '').lower()
    typ = request.args.get('type', 'szpitale')
    if typ == 'szpitale':
        rows = query_db("SELECT id, nazwa, lokalizacja, opis FROM szpitale WHERE lower(nazwa) LIKE ? OR lower(lokalizacja) LIKE ? OR lower(opis) LIKE ?", (f'%{q}%', f'%{q}%', f'%{q}%'))
    elif typ == 'urzadzenia':
        rows = query_db("SELECT id, nazwa, kategoria, opis FROM urzadzenia WHERE lower(nazwa) LIKE ? OR lower(kategoria) LIKE ? OR lower(opis) LIKE ?", (f'%{q}%', f'%{q}%', f'%{q}%'))
    else:
        rows = []
    return jsonify(rows)

if __name__ == '__main__':
    app.run(debug=True)
