Feature: Run command
  As a newcomer to lpn
  I want to be able to run the images managed by the tool

  Scenario Outline: Run command
    When I run `lpn run <type> -t <tag>`
    Then the output should contain:
    """
    The container [lpn-<type>] has been run sucessfully
    """
    And the exit status should be 0
    And I run `lpn rm <type>`

  Examples:
    | type    | tag |
    | commerce | latest |
    | nightly | latest |
    | release | latest |

  Scenario Outline: Run command with failure
    When I run `docker run -d --name nginx-<type> -p 9999:80 nginx:1.12.2-alpine`
    And I run `lpn run <type> -t <tag> -p 9999`
    Then the output should contain:
    """
    Impossible to run the container [lpn-<type>]
    """
    And the exit status should be 1
    And I run `lpn rm <type>`
    And I run `docker rm -fv nginx-<type>`

  Examples:
    | type    | tag |
    | commerce | latest |
    | nightly | latest |
    | release | latest |