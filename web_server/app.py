from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL

app = Flask(__name__)

# Required
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3306
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "project92"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


mysql = MySQL(app)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/31",methods=["GET","POST"])
def exc31():
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT DISTINCT
        	MasterStelexos as `ID`,
            FirstName,
            LastName
        FROM
            Ergo e 
            JOIN Stelexos s ON s.ID = e.MasterStelexos; 
    ''')
    stelexoi = cur.fetchall()
    result = []
    if request.method=="POST":
        
        duration = request.form.get("duration")
        if duration == '': duration=" IS NOT NULL"
        else: duration = '="{}"'.format(duration)
        
        start_date = request.form.get("start_date")
        if start_date == '': start_date=" IS NOT NULL"
        else: start_date = '="{}"'.format(start_date)
        
        end_date = request.form.get("end_date")
        if end_date == '': end_date=" IS NOT NULL"
        else: end_date = '="{}"'.format(end_date)
        
        stelexos = request.form.get("stelexos")
        if stelexos == '': stelexos=" IS NOT NULL"
        else: stelexos = '="{}"'.format(stelexos)
        
        
        cur.execute(''' 
            SELECT 
             	*
            FROM
             	Ergo
            WHERE
             	(Duration{}) AND (StartDate{}) AND (EndDate{}) AND (MasterStelexos{})
            ;'''.format(duration,start_date,end_date,stelexos))
        result = cur.fetchall()
    return render_template("exc31.html",stelexoi=stelexoi,result=result)


@app.route("/32")
def exc32():
    cur = mysql.connection.cursor()
    cur.execute("SELECT first_name,last_name,title from view1;")
    view1 = cur.fetchall()
    
    #cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM view2;")
    view2 = cur.fetchall()
    return render_template("exc32.html",view1=view1,view2=view2)

@app.route("/33",methods=["GET","POST"])
def exc33():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT Name from Pedio; ''')
    choices = cur.fetchall()
    result = []
    choice = 'Επιστημονικό πεδίο...'
    if request.method=="POST":
        choice = request.form.get('choice')
        cur.execute('''
            SELECT 
            	e.ID as `id_ergo`,
            	e.Title,
                r.ID as `id_researcher`,
            	r.FirstName,
            	r.LastName
            FROM
            	PedioRelation pr
            	INNER JOIN Ergo e ON pr.Ergo=e.ID
            	INNER JOIN WorksForErgo w ON w.Ergo=e.ID
                INNER JOIN Researcher r ON r.ID=w.Researcher
            WHERE 
            	pr.Pedio="{}"  AND EndDate > CURRENT_DATE() AND YEAR(CURRENT_DATE())-YEAR(StartDate)<=1 ; '''.format(choice))
        result = cur.fetchall()
    return render_template("exc33.html",choices=choices,result=result,name=choice)

@app.route("/34")
def exc34():
    cur = mysql.connection.cursor()
    
    cur.execute('''
        SELECT
        	v1.org_id, 
            v1.org_name, 
            v1.year as `year_1`, 
            v2.year as `year_2`, 
            v1.count
        FROM
        	view2 v1 
            JOIN view2 v2 ON v1.org_id=v2.org_id      
        WHERE
            v2.year=v1.year+1 AND v1.count>9 AND v1.count=v2.count;	
            ''')
    
    result = cur.fetchall()
    return render_template("exc34.html",result=result)

@app.route("/35")
def exc35():
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT 
        	T1.Pedio as `pedio1`,
            T2.Pedio as `pedio2`,
            COUNT(CONCAT(T1.Pedio, ',', T2.Pedio)) as `count`
        FROM
        	PedioRelation T1 
            INNER JOIN PedioRelation T2 ON 
            (T1.Ergo=T2.Ergo) AND (T1.Pedio < T2.Pedio)
        GROUP BY
        	`pedio1`,`pedio2`
        ORDER BY
        	`count` DESC
        LIMIT
        	3
        ; ''')
    result = cur.fetchall()
    return render_template("exc35.html",result=result)

@app.route("/36")
def exc36():
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT 
        	Researcher as 'researcher id',
            FirstName,
            LastName,
            COUNT(Researcher) as 'count',
            YEAR(CURRENT_DATE()) - YEAR(DoBirth) as 'age'
        FROM 
            WorksForErgo w
        		INNER JOIN Researcher r ON r.ID=w.Researcher
            	INNER JOIN Ergo e ON e.ID=w.Ergo
        WHERE 
        	YEAR(CURRENT_DATE()) - YEAR(DoBirth) < 40 AND EndDate>CURRENT_DATE()
        GROUP BY 
        	Researcher
        ORDER BY
        	`count` DESC; ''')
    result = cur.fetchall()
    return render_template("exc36.html",result=result)

@app.route("/37")
def exc37():
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT
            s.ID as `stelexos_id`,
        	s.FirstName,
            s.LastName,
            e.ID as `ergo_id`,
            e.Title,
            e.Budget
        FROM
        	Ergo e 
            JOIN Stelexos s ON e.MasterStelexos = s.ID
        ORDER BY
        	`Budget` DESC
        LIMIT 
            5; ''')
    result = cur.fetchall()
    return render_template("exc37.html",result=result)

@app.route("/38")
def exc38():
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT 
         V.researcher_ID,
            V.first_name,
            V.last_name,
            COUNT(V.Researcher_ID) as count
        FROM
         view1 V 
            LEFT OUTER JOIN Paradoteo p ON V.ergo_id=p.Ergo
        WHERE
          p.Ergo IS NULL
        GROUP BY
            V.researcher_ID
        HAVING
            `count`>4;''')
    result = cur.fetchall()
    return render_template("exc38.html",result=result)


if __name__ == "__main__":
    app.run(debug=True)
