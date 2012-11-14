<%@ tag import="com.google.common.collect.Iterables" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="light" uri="http://www.lightadmin.org/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ attribute name="filters" required="true" rtexprvalue="true" type="org.lightadmin.core.config.domain.filter.FiltersConfigurationUnit"%>

<tiles:useAttribute name="domainTypeAdministrationConfiguration"/>

<c:set var="tag_search_filterList" value="<%= Iterables.toArray( filters, org.lightadmin.core.config.domain.filter.FilterMetadata.class ) %>"/>

<c:if test="${not empty tag_search_filterList}">
	<div class="well well-small">
		<form action="" name="filter-form" class="form-horizontal">
			<fieldset>
				<c:forEach var="filter" items="${tag_search_filterList}">
					<c:if test="${light:isSimpleValueType(filter.type)}">
						<div class="control-group">
							<label class="control-label" for="${filter.fieldName}"><c:out value="${filter.name}"/></label>
							<div class="controls">
								<input name="${filter.fieldName}" type="text" class="input-xlarge"/>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</fieldset>
			<div class="controls">
				<button id="apply-filter" type="submit" class="btn btn-primary">Search</button>
				<button id="reset-filter" type="button" class="btn">Reset</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		$(function() {
			$("#reset-filter" ).click(function() {
				$("input", $("form[name='filter-form']") ).val('');
				searchScope(activeScopeName());
			});

			$("form[name='filter-form']").submit(function(event) {
				event.preventDefault();
				var filter_criteria = $("form[name='filter-form']" ).serialize();
				searchScope(activeScopeName(), filter_criteria );
			});
		});
	</script>
</c:if>