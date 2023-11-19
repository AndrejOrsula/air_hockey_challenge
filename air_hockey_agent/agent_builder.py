from air_hockey_challenge.framework import AgentBase

from drl_air_hockey import (
    MultiStrategySpaceRAgent,
    SingleStrategySpaceRAgent,
    SpaceRAgent,
)

SPACER_AGENT: AgentBase = SingleStrategySpaceRAgent


def build_agent(env_info, **kwargs):
    """
    Function where an Agent that controls the environments should be returned.
    The Agent should inherit from the mushroom_rl Agent base env.

    Args:
        env_info (dict): The environment information
        kwargs (any): Additionally setting from agent_config.yml
    Returns:
         (AgentBase) An instance of the Agent
    """

    return SPACER_AGENT(env_info, **kwargs)
