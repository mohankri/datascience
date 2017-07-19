require(ggplot2)

titan <- read.csv("~/datascience/springboard/project/titanic_clean.csv", header = TRUE, sep = ",")
str(titan)

tail(titan)
titan <- titan[-1310,]

ggplot(titan,aes(x=factor(pclass),fill=factor(sex)))+
  geom_bar(position="dodge")

ggplot(titan,aes(x=factor(pclass),fill=factor(sex)))+
  geom_bar(position="dodge")+
  facet_grid(". ~ survived")

posn.j <- position_jitter(0.5, 0)

ggplot(titan,aes(x=factor(pclass),y=age,col=factor(sex)))+
  geom_jitter(size=3,alpha=0.5,position=posn.j)+
  facet_grid(". ~ survived")