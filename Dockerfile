# Use latest jboss/base-jdk:7 image as the base
FROM jboss/base-jdk:8

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 12.0.0.Final

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx && mv $HOME/wildfly-$WILDFLY_VERSION $HOME/wildfly

# ADD BusinessNetAdmin-0.0.1-SNAPSHOT.ear /opt/jboss/wildfly/standalone/deployments/
COPY wildfly /opt/jboss/
# ADD standalone.conf /opt/jboss/wildfly/bin/

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss/wildfly

# Expose the ports we're interested in

EXPOSE 8282 9990

#RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent
# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface

CMD ["/opt/jboss/wildfly/bin/standalone.sh"]
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
