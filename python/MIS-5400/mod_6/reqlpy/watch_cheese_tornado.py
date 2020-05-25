import rethinkdb as r

# Connect, defaults are 'localhost', 28015, and the 'test' db.
conn = r.connect(host='localhost', port=28015, db='CheeseTornado')

# monitor for changes
cheese_cursor = r.table('Cheese').changes().run(conn)
for cheese in cheese_cursor:
    print(cheese)

