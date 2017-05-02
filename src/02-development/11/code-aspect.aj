aspect LoggingAspect {
	/* $У аспектов могут быть переменные.$ */
	Logger logger = // ...

	/* $Определение среза: вызов метода Point.setX или Point.setY.$ */
	pointcut setter(): target(Point)
			&& (call(void setX(double))
			|| call(void setY(double)));

	/* $Совет: занести в лог запись после выполнения метода.$ */
	/* $В \code{p} и \code{val} извлекаются объект, вызвавший метод, и аргумент метода.$ */
	after(Point p, double val): setter() && target(p) && args(val) {
		logger.info("Set value " + val + " for point " + p);
	}
}
