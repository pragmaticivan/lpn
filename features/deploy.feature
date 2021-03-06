Feature: Deploy command
  As a newcomer to lpn
  I want to be able to deploy files and directories to the container created by the tool

  Scenario Outline: Deploy one single file when container exists
    Given an empty file named "modules/a.jar"
    When I run `lpn run <type> -t <tag>`
    And I run `lpn deploy <type> -f modules/a.jar`
    Then the output should contain:
    """
    [modules/a.jar] deployed sucessfully to /liferay/deploy
    """
    And I run `docker exec lpn-<type> ls -l /liferay/deploy | grep "a.jar" | wc -l | xargs`
    And the output should contain:
    """
    1
    """
    And I run `lpn rm <type>`

  Examples:
    | type    | tag |
    | commerce | latest |
    | nightly | latest |
    | release | latest |

  Scenario Outline: Deploy multiple file when container exists
    Given an empty file named "modules/a.jar"
    And an empty file named "modules/b.jar"
    When I run `lpn run <type> -t <tag>`
    And I run `lpn deploy <type> -f modules/a.jar,modules/b.jar`
    Then the output should contain:
    """
    [modules/a.jar] deployed sucessfully to /liferay/deploy
    """
    And the output should contain:
    """
    [modules/b.jar] deployed sucessfully to /liferay/deploy
    """
    And I run `docker exec lpn-<type> ls -l /liferay/deploy | grep "a.jar" | wc -l | xargs`
    And the output should contain:
    """
    1
    """
    And I run `docker exec lpn-<type> ls -l /liferay/deploy | grep "b.jar" | wc -l | xargs`
    And the output should contain:
    """
    1
    """
    And I run `lpn rm <type>`

  Examples:
    | type    | tag |
    | commerce | latest |
    | nightly | latest |
    | release | latest |

  Scenario Outline: Deploy command with no flags
    When I run `lpn run <type> -t <tag>`
    And I run `lpn deploy <type>`
    Then the output should contain:
    """
    Please pass a valid path to a file or to a directory as argument
    """
    And the exit status should be 1
    And I run `lpn rm <type>`

  Examples:
    | type    | tag |
    | commerce | latest |
    | nightly | latest |
    | release | latest |

  Scenario Outline: Deploy a directory when container exists
    Given an empty file named "modules/a.jar"
    And an empty file named "modules/b.jar"
    And an empty file named "modules/c.jar"
    When I run `lpn run <type> -t <tag>`
    And I run `docker exec lpn-<type> mkdir -p <home>`
    And I run `lpn deploy <type> -d modules`
    Then the output should contain:
    """
    [modules/a.jar] deployed sucessfully to <home>
    """
    And I run `docker exec lpn-<type> ls -l <home> | grep "a.jar" | wc -l | xargs`
    And the output should contain:
    """
    1
    """
    And the output should contain:
    """
    [modules/b.jar] deployed sucessfully to <home>
    """
    And I run `docker exec lpn-<type> ls -l <home> | grep "b.jar" | wc -l | xargs`
    And the output should contain:
    """
    1
    """
    And the output should contain:
    """
    [modules/c.jar] deployed sucessfully to <home>
    """
    And I run `docker exec lpn-<type> ls -l <home> | grep "c.jar" | wc -l | xargs`
    And the output should contain:
    """
    1
    """
    And I run `lpn rm <type>`

    Examples:
    | type | tag | home |
    | commerce | latest | /liferay/deploy |
    | nightly | latest | /liferay/deploy |
    | release | latest | /liferay/deploy |
    | release | 7-ce-ga5-tomcat-hsql | /usr/local/liferay-ce-portal-7.0-ga5/deploy |

  Scenario Outline: Deploy a directory skipping subdirectories when container exists
    Given an empty directory named "modules/skip1"
    And an empty directory named "modules/skip2"
    When I run `lpn run <type> -t <tag>`
    And I run `lpn deploy <type> -d modules`
    Then the output should not contain:
    """
    [modules/skip1] deployed sucessfully to <home>
    """
    And I run `docker exec lpn-<type> ls -l <home> | grep "skip1" | wc -l | xargs`
    And the output should contain:
    """
    0
    """
    And the output should not contain:
    """
    [modules/skip2] deployed sucessfully to <home>
    """
    And I run `docker exec lpn-<type> ls -l <home> | grep "skip2" | wc -l | xargs`
    And the output should contain:
    """
    0
    """
    And I run `lpn rm <type>`

    Examples:
    | type | tag | home |
    | commerce | latest | /liferay/deploy |
    | nightly | latest | /liferay/deploy |
    | release | latest | /liferay/deploy |
    | release | 7-ce-ga5-tomcat-hsql | /usr/local/liferay-ce-portal-7.0-ga5/deploy |